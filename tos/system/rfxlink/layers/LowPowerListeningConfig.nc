interface LowPowerListeningConfig
{
	/**
	 * Returns TRUE if an acknowledgement has been requested for 
	 * this message via the PacketAcknowledgements interface.
	 */
	command bool ackRequested(message_t* msg);
}
