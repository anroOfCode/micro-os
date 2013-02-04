interface RandomCollisionConfig
{
	/**
	 * The provided message was just received, and this command should return 
	 * the time till no transmission should be initiated.
	 */
	async command uint16_t getTransmitBarrier(message_t* msg);
}
