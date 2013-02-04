interface LinkPacketMetadata {

  /**
   * Return true if the channel during this packet had high quality (few bit errors).
   * A good rule of thumb for "high quality" is that the channel quality
   * would enable MTU packets to have a reception rate of 90% or greater.
   *
   * @param 'message_t* ONE msg' A received packet during which the channel was measured.
   * @return Whether the channel had high quality.
   */
  async command bool highChannelQuality(message_t* msg);

}
