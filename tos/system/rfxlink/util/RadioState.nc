#include <Tasklet.h>

interface RadioState
{
	/**
	 * Moves to radio into sleep state with the lowest power consumption but 
	 * highest wakeup time. The radio cannot send or receive in this state 
	 * and releases all access to shared resources (e.g. SPI bus). 
	 */
	tasklet_async command error_t turnOff();

	/**
	 * The same as the turnOff command, except it is not as deep sleep, and
	 * it is quicker to recover from this state.
	 */
	tasklet_async command error_t standby();

	/**
	 * Goes into receive state. The radio continuously receive messages 
	 * and able to transmit.
	 */
	tasklet_async command error_t turnOn();

	/**
	 * Sets the current channel. Returns EBUSY if the stack is unable
	 * to change the channel this time (some other operation is in progress)
	 * SUCCESS otherwise.
	 */
	tasklet_async command error_t setChannel(uint8_t channel);

	/**
	 * This event is signaled exactly once for each sucessfully posted state 
	 * transition and setChannel command when it is completed.
	 */
	tasklet_async event void done();

	/**
	 * Returns the currently selected channel.
	 */
	tasklet_async command uint8_t getChannel();
}
