#ifndef DALLASID48_H
#define DALLASID48_H

enum {
    DALLASID48_SERIAL_LENGTH = 6,
    DALLASID48_DATA_LENGTH = 8
};

typedef union dallasid48_serial_t {
    uint8_t data[DALLASID48_DATA_LENGTH];
    struct {
        uint8_t family_code;
        uint8_t serial[DALLASID48_SERIAL_LENGTH];
        uint8_t crc;
    };
} dallasid48_serial_t;

#endif // DALLASID48_H
