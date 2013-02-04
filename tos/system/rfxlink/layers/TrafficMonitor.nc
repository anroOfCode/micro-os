interface TrafficMonitor
{
	/**
	 * Returns the number of times the radio driver was started.
	 */
	async command uint32_t getStartCount();

	/**
	 * Returns the current time (same as LocalTime<TMilli>.get)
	 */
	async command uint32_t getCurrentTime();

	/**
	 * Returns the total number of milliseconds the radio driver
	 * was operating (between start() and stopDone()).
	 */
	async command uint32_t getActiveTime();

	/**
	 * Returns the number of messages the radio driver has 
	 * transmitted (those for which send() returned with SUCCESS, 
	 * even though sendDone() might have returned with an error).
	 */
	async command uint32_t getTxMessages();

	/**
	 * Returns the number of messages the radio driver has 
	 * received. 
	 */
	async command uint32_t getRxMessages();

	/**
	 * Returns the sum of the lengths of all transmitted 
	 * messages (those for which send() returned with SUCCESS,
	 * even though sendDone() might have returned with an error).
	 * This count includes all preamble, STD and CRC bytes.
	 */
	async command uint32_t getTxBytes();

	/**
	 * Returns the sum of the lengths of all received 
	 * messages. This count includes all preamble, STD 
	 * and CRC bytes.
	 */
	async command uint32_t getRxBytes();

	/**
	 * Returns the number of times send() or sendDone()
	 * returned with an error.
	 */
	async command uint32_t getTxErrors();
}
