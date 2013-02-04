#include <Tasklet.h>

interface RadioReceive
{
	/**
	 * This event is fired when the header is received/downloaded and the 
	 * higher layers are consulted whether it needs to be downloaded and 
	 * further processed. Return FALSE if the message should be discarded.
	 * In particular, the message buffer layer returns FALSE if there is
	 * no space for a new message, so this message will not get acknowledged.
	 */
	tasklet_async event bool header(message_t* msg);

	/**
	 * Signals the reception of a message, but only for those messages for
	 * which SUCCESS was returned in the header event. The usual owner rules 
	 * apply to the message pointers.
	 */
	tasklet_async event message_t* receive(message_t* msg);
}
