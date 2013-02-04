generic configuration DebugLayerC(char prefix[])
{
	provides
	{
		interface RadioState;
		interface RadioSend;
		interface RadioReceive;
	}

	uses 
	{
		interface RadioState as SubState;
		interface RadioSend as SubSend;
		interface RadioReceive as SubReceive;
	}
}

implementation
{
	components new DebugLayerP(prefix), DiagMsgC;

	RadioState = DebugLayerP;
	RadioSend = DebugLayerP;
	RadioReceive = DebugLayerP;
	SubState = DebugLayerP;
	SubSend = DebugLayerP;
	SubReceive = DebugLayerP;

	DebugLayerP.DiagMsg -> DiagMsgC;
}
