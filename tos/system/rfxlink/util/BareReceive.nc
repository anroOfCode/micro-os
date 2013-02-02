#include <message.h>

interface BareReceive
{
	/**
	 * Signals the reception of a message, but only for those messages for
	 * which SUCCESS was returned in the header event. The usual owner rules 
	 * apply to the message pointers.
	 */
	event message_t* receive(message_t* msg);
}
