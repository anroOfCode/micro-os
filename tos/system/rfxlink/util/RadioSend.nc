#include <Tasklet.h>

interface RadioSend
{
	/**
	 * Starts the transmission of the given message. This command must not
	 * be called while another send is in progress (so one must wait for the
	 * sendDone event). Returns EBUSY if a reception is in progress or for
	 * some other reason the request cannot be temporarily satisfied (e.g.
	 * the SPI bus access could not be acquired). In this case the send 
	 * command could be retried from a tasklet. Returns SUCCESS if the 
	 * transmission could be started. In this case sendDone will be fired.
	 */
	tasklet_async command error_t send(message_t* msg);
	
	/**
	 * Signals the completion of the send command, exactly once for each 
	 * successfull send command. If the returned error code is SUCCESS, then 
	 * the message was sent (may not have been acknowledged), otherwise 
	 * the message was not transmitted over the air.
	 */
	tasklet_async event void sendDone(error_t error);

	/**
	 * This event is fired when the component is most likely able to accept 
	 * a send request. If the send command has returned with a failure, then
	 * this event will be called at least once in the near future.
	 */
	tasklet_async event void ready();
}
