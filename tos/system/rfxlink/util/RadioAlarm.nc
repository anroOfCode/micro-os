#include <Tasklet.h>
#include "RadioConfig.h"

interface RadioAlarm
{
	/**
	 * Returns TRUE if the alarm is free and ready to be used. Once the alarm
	 * is free, it cannot become nonfree in the same tasklet block. Note,
	 * if the alarm is currently set (even if for ourselves) then it is not free.
	 */
	tasklet_async command bool isFree();

	/**
	 * Waits till the specified timeout period expires. The alarm must be free.
	 */
	tasklet_async command void wait(tradio_size timeout);

	/**
	 * Cancels the running alarm. The alarm must be pending.
	 */
	tasklet_async command void cancel();

	/**
	 * This event is fired when the specified timeout period expires.
	 */
	tasklet_async event void fired();

	/**
	 * Returns the current time as measured by the radio stack.
	 */
	async command tradio_size getNow();
}
