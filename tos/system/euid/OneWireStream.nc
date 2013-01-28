interface OneWireStream {
    command error_t read(uint8_t cmd, uint8_t* buf, uint8_t len);
    command error_t write(const uint8_t* buf, uint8_t len);
}

