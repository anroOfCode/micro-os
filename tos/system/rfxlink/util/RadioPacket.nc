interface RadioPacket
{
	/**
	 * This command returns the length of the header. The header
	 * starts at the first byte of the message_t structure 
	 * (some layers may add dummy bytes to allign the payload to
	 * the msg->data section).
	 */
	async command uint8_t headerLength(message_t* msg);

	/**
	 * Returns the length of the payload. The payload starts right
	 * after the header.
	 */
	async command uint8_t payloadLength(message_t* msg);

	/**
	 * Sets the length of the payload.
	 */
	async command void setPayloadLength(message_t* msg, uint8_t length);

	/**
	 * Returns the maximum length that can be set for this message.
	 */
	async command uint8_t maxPayloadLength();

	/**
	 * Returns the length of the metadata section. The metadata section
	 * is at the very end of the message_t structure and grows downwards.
	 */
	async command uint8_t metadataLength(message_t* msg);

	/**
	 * Clears all metadata and sets all default values in the headers.
	 */
	async command void clear(message_t* msg);
}
