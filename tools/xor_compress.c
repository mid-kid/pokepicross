#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <errno.h>

#define PROGRAM_NAME "xor_compress"

extern int errno;

size_t file_size(FILE *f) {
    if (fseek(f, 0, SEEK_END) == -1) return 0;
    long f_size = ftell(f);
    if (f_size == -1) return 0;
    if (fseek(f, 0, SEEK_SET) == -1) return 0;
    return (size_t)f_size;
}

unsigned char *read_files(char *filenames[], int num_files, size_t *buf_size, int *err) {
    *buf_size = 0;
    unsigned char *buffer = NULL;

    const char *filename = NULL;
    for (int i = 0; i < num_files; i++) {
        filename = filenames[i];

        FILE *f = fopen(filename, "rb");
        if (!f) goto failure;

        size_t f_size = file_size(f);
        if (errno) goto failure;
        if (!f_size) continue;

        *buf_size += f_size;
        buffer = realloc(buffer, *buf_size);
        if (!buffer) goto failure;

        unsigned char *buf_end = buffer + (*buf_size - f_size);
        size_t read_size = fread(buf_end, 1, f_size, f);
        fclose(f);
        if (read_size != f_size) {
            // fread does not set errno
            fprintf(stderr, PROGRAM_NAME ": %s: Read error\n", filename);
            *err = 1;
            return buffer;
        }
    }

    *err = 0;
    return buffer;

failure:
    fprintf(stderr, PROGRAM_NAME ": %s: %s\n", filename, strerror(errno));
    *err = errno;
    return buffer;
}

int write_compressed(const char *filename, unsigned char *data, size_t n, bool verbose) {
    FILE *f = fopen(filename, "wb");
    if (!f) {
        fprintf(stderr, PROGRAM_NAME ": %s: %s\n", filename, strerror(errno));
        return errno;
    }

    int runs = 0;
    unsigned char v = 0x00;
    for (size_t i = 0; i < n; runs++) {
        unsigned char byte = data[i++];
        unsigned char size = 0;
        if (data[i] == v) {
            // Alternating (>= 0x80)
            // Run stops at 0x80 bytes or when the values stop alternating
            for (; i < n && size < 0x80 && data[i] == ((size % 2) ? byte : v); size++, i++);
            fputc(size + 0x7f, f);
            fputc(v ^ byte, f);
            if (size % 2 == 0) v = byte;
        } else {
            // Sequential (< 0x80)
            // Run stops at 0x80 bytes or when the value two ahead is equal to v
            unsigned char buffer[256];
            buffer[size++] = v ^ byte;
            for (; i < n; i++) {
                v = byte;
                if (size > 0x7f || (i + 1 < n && data[i + 1] == v)) break;
                byte = data[i];
                buffer[size++] = v ^ byte;
            }
            fputc(size - 1, f);
            fwrite(buffer, 1, size, f);
        }
    }

    if (verbose) fprintf(stderr, PROGRAM_NAME ": %s: ld bc, $%x\n", filename, runs);

    fflush(f);
    fclose(f);
    return 0;
}

int main(int argc, char *argv[]) {
    bool verbose = false;
    if (argc > 1 && !strcmp(argv[1], "-v")) {
        verbose = true;
        argv++;
        argc--;
    }

    if (argc < 3) {
        fputs("Usage: " PROGRAM_NAME " [-v] file... files.xor\n", stderr);
        exit(1);
    }
    argv++;
    argc -= 2;

    int err = 0;
    size_t data_size = 0;
    unsigned char *data = read_files(argv, argc, &data_size, &err);
    if (!err) err = write_compressed(argv[argc], data, data_size, verbose);
    free(data);
    return err;
}
