interface SpiPacket {

  /**
   * Send a message over the SPI bus.
   *
   * @param 'uint8_t* COUNT_NOK(len) txBuf' A pointer to the buffer to send over the bus. If this
   *              parameter is NULL, then the SPI will send zeroes.
   * @param 'uint8_t* COUNT_NOK(len) rxBuf' A pointer to the buffer where received data should
   *              be stored. If this parameter is NULL, then the SPI will
   *              discard incoming bytes.
   * @param len   Length of the message.  Note that non-NULL rxBuf and txBuf
   *              parameters must be AT LEAST as large as len, or the SPI
   *              will overflow a buffer.
   *
   * @return SUCCESS if the request was accepted for transfer
   */
  async command error_t send( uint8_t* txBuf, uint8_t* rxBuf, uint16_t len );

  /**
   * Notification that the send command has completed.
   *
   * @param 'uint8_t* COUNT_NOK(len) txBuf' The buffer used for transmission
   * @param 'uint8_t* COUNT_NOK(len) rxBuf' The buffer used for reception
   * @param len    The request length of the transfer, but not necessarily
   *               the number of bytes that were actually transferred
   * @param error  SUCCESS if the operation completed successfully, FAIL
   *               otherwise
   */
  async event void sendDone( uint8_t* txBuf, uint8_t* rxBuf, uint16_t len,
                             error_t error );

}
