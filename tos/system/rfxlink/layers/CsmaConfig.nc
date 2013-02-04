interface CsmaConfig
{
	/**
	 * This command is called when the message is transmitted to
	 * check if it needs software clear channel assesment.
	 */
	async command bool requiresSoftwareCCA(message_t* msg);
}
