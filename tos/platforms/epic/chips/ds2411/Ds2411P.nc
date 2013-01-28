// [TODO]: This code doesn't belong in the platform directory. It should
// be moved into the chip directory and require a HPL in the platform
// directory.

#include "DallasId48.h"

module Ds2411P {
    provides {
        interface ReadId48;
    }
    uses {
        interface OneWireStream as OneWire;
    }
}
implementation {
    bool haveId = FALSE;
    dallasid48_serial_t ds2411id;

    // The CRC polynomial is X^8 + X^5 + X^4 + 1,
    // code is taken from http://linux.die.net/man/3/_crc_ccitt_update

    bool dallasid48checkCrc(const dallasid48_serial_t *id) {
        uint8_t crc = 0;
        uint8_t idx;
        for(idx = 0; idx < DALLASID48_DATA_LENGTH; idx++) {
            uint8_t i;
            crc = crc ^ (*id).data[idx];
            for(i = 0; i < 8; i++) {
                if(crc & 0x01) {
                    crc = (crc >> 1) ^ 0x8C;
                }
                else {
                    crc >>= 1;
                }
            }
        }
        return crc == 0;
    }

    error_t readId() {
        error_t e = call OneWire.read(0x33, ds2411id.data, DALLASID48_DATA_LENGTH);
        if(e == SUCCESS) {
            if(dallasid48checkCrc(&ds2411id)) {
                haveId = TRUE;
            }
            else {
                e = EINVAL;
            }
        }
        return e;
    }
    
    command error_t ReadId48.read(uint8_t *id) {
        error_t e = SUCCESS;
        if(!haveId) {
            e = readId();
        }
        if(haveId) {
            uint8_t i;
            for(i = 0; i < DALLASID48_SERIAL_LENGTH; i++) {
                id[i] = ds2411id.serial[i];
            }
        }
        return e;
    }
}
