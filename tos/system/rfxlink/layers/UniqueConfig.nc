#include <Tasklet.h>

interface UniqueConfig
{
	/**
	 * Returns the sequence number of the packet.
	 */
	async command uint8_t getSequenceNumber(message_t* msg);

	/**
	 * Returns the sender of the packet. 
	 */
	async command ieee154_addr_t getSender(message_t* msg);

	/**
	 * Sets the sequence number of the packet.
	 */
	async command void setSequenceNumber(message_t*msg, uint8_t number);

	/**
	 * This command is called when the unqiue layer detects a missing (jump 
	 * in the data sequence number) or a duplicate packet.
	 */
	tasklet_async command void reportChannelError();
}
