interface UartStream {

  /**
   * Begin transmission of a UART stream. If SUCCESS is returned,
   * <code>sendDone</code> will be signalled when transmission is
   * complete.
   *
   * @param 'uint8_t* COUNT(len) buf' Buffer for bytes to send.
   * @param len Number of bytes to send.
   * @return SUCCESS if request was accepted, FAIL otherwise.
   */
  async command error_t send( uint8_t* buf, uint16_t len );

  /**
   * Signal completion of sending a stream.
   *
   * @param 'uint8_t* COUNT(len) buf' Bytes sent.
   * @param len Number of bytes sent.
   * @param error SUCCESS if the transmission was successful, FAIL otherwise.
   */
  async event void sendDone( uint8_t* buf, uint16_t len, error_t error );

  /**
   * Enable the receive byte interrupt. The <code>receive</code> event
   * is signalled each time a byte is received.
   *
   * @return SUCCESS if interrupt was enabled, FAIL otherwise.
   */
  async command error_t enableReceiveInterrupt();

  /**
   * Disable the receive byte interrupt.
   *
   * @return SUCCESS if interrupt was disabled, FAIL otherwise.
   */
  async command error_t disableReceiveInterrupt();

  /**
   * Signals the receipt of a byte.
   *
   * @param byte The byte received.
   */
  async event void receivedByte( uint8_t byte );

  /**
   * Begin reception of a UART stream. If SUCCESS is returned,
   * <code>receiveDone</code> will be signalled when reception is
   * complete.
   *
   * @param 'uint8_t* COUNT(len) buf' Buffer for received bytes.
   * @param len Number of bytes to receive.
   * @return SUCCESS if request was accepted, FAIL otherwise.
   */
  async command error_t receive( uint8_t* buf, uint16_t len );

  /**
   * Signal completion of receiving a stream.
   *
   * @param 'uint8_t* COUNT(len) buf' Buffer for bytes received.
   * @param len Number of bytes received.
   * @param error SUCCESS if the reception was successful, FAIL otherwise.
   */
  async event void receiveDone( uint8_t* buf, uint16_t len, error_t error );

}
