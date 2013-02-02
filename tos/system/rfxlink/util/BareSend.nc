#include <message.h>

interface BareSend
{
	/**
	 * Starts the transmission of the given message. This command must not
	 * be called while another send is in progress (so one must wait for the
	 * sendDone event). Returns EBUSY if a reception is in progress or for
	 * some other reason the request cannot be temporarily satisfied (e.g.
	 * the SPI bus access could not be acquired). In this case the send 
	 * command could be retried from a task. Returns SUCCESS if the 
	 * transmission could be started. In this case sendDone will be fired.
	 */
	command error_t send(message_t* msg);
	
	/**
	 * Signals the completion of the send command, exactly once for each 
	 * successfull send command. If the returned error code is SUCCESS, then 
	 * the message was sent (may not have been acknowledged), otherwise 
	 * the message was not transmitted over the air.
	 */
	event void sendDone(message_t* msg, error_t error);

	/**
	 * Cancel a requested transmission. Returns SUCCESS if the 
	 * transmission was cancelled properly (not sent in its
	 * entirety). Note that the component may not know
	 * if the send was successfully cancelled, if the radio is
	 * handling much of the logic; in this case, a component
	 * should be conservative and return an appropriate error code.
	 */
	command error_t cancel(message_t* msg);
}
