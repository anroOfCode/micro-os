interface RadioChannel
{
	/**
	 * Sets the current channel. Returns EBUSY if the stack is unable
	 * to change the channel this time (some other operation is in progress),
	 * EALREADY if the selected channel is already set, SUCCESS otherwise.
	 */
	command error_t setChannel(uint8_t channel);

	/**
	 * This event is signaled exactly once for each sucessfully posted state 
	 * setChannel command when it is completed.
	 */
	event void setChannelDone();

	/**
	 * Returns the currently selected channel.
	 */
	command uint8_t getChannel();
}
