interface SpiByte
{
  /**
   * Synchronous transmit and receive (can be in interrupt context)
   * @param tx Byte to transmit
   * @param rx Received byte is stored here.
   */
  async command uint8_t write( uint8_t tx );
}
