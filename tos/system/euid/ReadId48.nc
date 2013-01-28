interface ReadId48  {
    // the ID is written into the buffer pointed to by id,
    // the buffer must be at least 6 bytes (or 48 bit) long
    command error_t read(uint8_t *id);
}
