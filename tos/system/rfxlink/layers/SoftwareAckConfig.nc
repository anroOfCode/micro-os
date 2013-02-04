#include <Tasklet.h>

interface SoftwareAckConfig
{
	/**
	 * Sets the flag in the message indicating to the receiver whether
	 * the message should be acknowledged.
	 */
	async command void setAckRequired(message_t* msg, bool ack);
	 
	/**
	 * Returns TRUE if the layer should wait for a software acknowledgement
	 * to be received after this packet was transmitted.
	 */
	async command bool requiresAckWait(message_t* msg);

	/**
	 * Returns TRUE if the received packet is an acknowledgement packet.
	 * The AckedSend layer will filter out all received acknowledgement
	 * packets and uses  only the matching one for the acknowledgement.
	 */
	async command bool isAckPacket(message_t* msg);

	/**
	 * Returns TRUE if the acknowledgement packet corresponds to the
	 * data packet. The acknowledgement packect was already verified 
	 * to be a valid acknowledgement packet via the isAckPacket command.
	 */
	async command bool verifyAckPacket(message_t* data, message_t* ack);

	/**
	 * Returns TRUE if the received packet needs software acknowledgements
	 * to be sent back to the sender.
	 */
	async command bool requiresAckReply(message_t* msg);

	/**
	 * Creates an acknowledgement packet for the given data packet.
	 */
	async command void createAckPacket(message_t* data, message_t* ack);

	/**
	 * This command is called when a sent packet did not receive an
	 * acknowledgement.
	 */
	tasklet_async command void reportChannelError();
}
