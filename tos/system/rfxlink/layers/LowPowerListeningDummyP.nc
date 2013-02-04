generic module LowPowerListeningDummyP()
{
	provides interface LowPowerListening;
}

implementation
{
	command void LowPowerListening.setLocalWakeupInterval(uint16_t intervalMs) { }

	command uint16_t LowPowerListening.getLocalWakeupInterval() { return 0; }
  
	command void LowPowerListening.setRemoteWakeupInterval(message_t *msg, uint16_t intervalMs) { }
  
	command uint16_t LowPowerListening.getRemoteWakeupInterval(message_t *msg) { return 0; }
}
