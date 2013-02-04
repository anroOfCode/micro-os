interface LowPowerListeningConfig
{
	/**
	 * Returns TRUE if an acknowledgement has been requested for 
	 * this message via the PacketAcknowledgements interface.
	 */
	command bool ackRequested(message_t* msg);

	/**
	 * Returns the number of milliseconds the mote should turn on
	 * its radio to check for incoming messages. This check is 
	 * performed at every localWakeInterval.
	 */
	command uint16_t getListenLength();
}
