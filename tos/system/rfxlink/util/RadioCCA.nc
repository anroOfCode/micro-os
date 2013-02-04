#include <Tasklet.h>

interface RadioCCA
{
	/**
	 * Starts the clear channel assesment procedure. Returns EBUSY if the radio
	 * is currently servicing a clear channel assesment, and SUCCESS otherwise.
	 * The check will be performed only in the RX_READY state.
	 */
	tasklet_async command error_t request();

	/**
	 * Signals the completion of the clear channel assesment send command.
	 * SUCCESS means the channel is clear, EBUSY means the channel is not
	 * clear, and FAIL means that the clear channel assesment could not
	 * be finished or the operation was cancelled.
	 */
	tasklet_async event void done(error_t error);
}
