interface UartByte {

  /**
   * Send a single uart byte. The call blocks until it is ready to
   * accept another byte for sending.
   *
   * @param byte The byte to send.
   * @return SUCCESS if byte was sent, FAIL otherwise.
   */
  async command error_t send( uint8_t byte );

  /**
   * Receive a single uart byte. The call blocks until a byte is
   * received.
   *
   * @param 'uint8_t* ONE byte' Where to place received byte.
   * @param timeout How long in byte times to wait.
   * @return SUCCESS if a byte was received, FAIL if timed out.
   */
  async command error_t receive( uint8_t* byte, uint8_t timeout );

}
