interface PacketField<value_type>
{
	/**
	 * Returns TRUE if the value is set for this message.
	 */
	async command bool isSet(message_t* msg);

	/**
	 * Returns the stored value of this field in the message. If the
	 * value is not set, then the returned value is undefined.
	 */
	async command value_type get(message_t* msg);

	/**
	 * Clears the isSet flag.
	 */
	async command void clear(message_t* msg);

	/**
	 * Sets the isSet false to TRUE and the time stamp value to the 
	 * specified value.
	 */
	async command void set(message_t* msg, value_type value);
}
