interface TrafficMonitorConfig
{
	/**
	 * Returns the number of bytes in this message.
	 */
	async command uint16_t getBytes(message_t* msg);
}
