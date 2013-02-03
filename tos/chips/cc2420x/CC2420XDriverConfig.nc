interface CC2420XDriverConfig
{
	/**
	 * Returns the length of a dummy header to align the payload properly.
	 */
	async command uint8_t headerLength(message_t* msg);

	/**
	 * Returns the maximum length of the PHY payload including the 
	 * length field but not counting the FCF field.
	 */
	async command uint8_t maxPayloadLength();

	/**
	 * Returns the length of a dummy metadata section to align the
	 * metadata section properly.
	 */
	async command uint8_t metadataLength(message_t* msg);

	/**
	 * Gets the number of bytes we should read before the RadioReceive.header
	 * event is fired. If the length of the packet is less than this amount, 
	 * then that event is fired earlier. The header length must be at least one.
	 */
	async command uint8_t headerPreloadLength();

	/**
	 * Returns TRUE if before sending this message we should make sure that
	 * the channel is clear via a very basic (and quick) RSSI check.
	 */
	async command bool requiresRssiCca(message_t* msg);
}
