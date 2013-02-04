interface PacketFlag
{
	/**
	 * Returns if the flag is set for this message. 
	 */
	async command bool get(message_t* msg);

	/**
	 * Sets the flag in this message to the specified value.
	 */
	async command void setValue(message_t* msg, bool value);

	/**
	 * Sets the flag in this message to TRUE
	 */
	async command void set(message_t* msg);

	/**
	 * Sets the flag in this message to FALSE
	 */
	async command void clear(message_t* msg);
}
