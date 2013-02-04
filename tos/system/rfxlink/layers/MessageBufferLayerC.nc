generic configuration MessageBufferLayerC()
{
	provides
	{
		interface SplitControl;
		interface BareSend as Send;
		interface BareReceive as Receive;
		interface RadioChannel;
	}
	uses
	{
		interface RadioState;
		interface RadioSend;
		interface RadioReceive;
	}
}

implementation
{
	components new MessageBufferLayerP(), MainC, TaskletC;

	MainC.SoftwareInit -> MessageBufferLayerP;

	SplitControl = MessageBufferLayerP;
	Send = MessageBufferLayerP;
	Receive = MessageBufferLayerP;
	RadioChannel = MessageBufferLayerP;

	RadioState = MessageBufferLayerP;
	MessageBufferLayerP.Tasklet -> TaskletC;
	RadioSend = MessageBufferLayerP;
	RadioReceive = MessageBufferLayerP;
}
