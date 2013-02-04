interface RandomCollisionConfig
{
	/**
	 * Returns the initial amount of maximum backoff for this message.
	 */
	async command uint16_t getInitialBackoff(message_t* msg);

	/**
	 * Returns the amount of maximum backoff when there is congestion
	 * (the channel was busy for the first try)
	 */
	async command uint16_t getCongestionBackoff(message_t* msg);

	/**
	 * Returns the minimum ticks before the message could be sent.
	 */
	async command uint16_t getMinimumBackoff();

	/**
	 * The provided message was just received, and this command should return 
	 * the time till no transmission should be initiated.
	 */
	async command uint16_t getTransmitBarrier(message_t* msg);
}
