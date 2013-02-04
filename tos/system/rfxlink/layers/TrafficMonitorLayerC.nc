generic configuration TrafficMonitorLayerC()
{
	provides
	{
		interface RadioSend;
		interface RadioReceive;
		interface RadioState;

		interface TrafficMonitor;
	}
	uses
	{
		interface RadioSend as SubSend;
		interface RadioReceive as SubReceive;
		interface RadioState as SubState;

		interface TrafficMonitorConfig as Config;
	}
}

implementation
{
	components new TrafficMonitorLayerP(), LocalTimeMilliC;

	RadioSend = TrafficMonitorLayerP;
	RadioReceive = TrafficMonitorLayerP;
	RadioState = TrafficMonitorLayerP;
	TrafficMonitor = TrafficMonitorLayerP;
	
	SubSend = TrafficMonitorLayerP;
	SubReceive = TrafficMonitorLayerP;
	SubState = TrafficMonitorLayerP;
	Config = TrafficMonitorLayerP;
	TrafficMonitorLayerP.LocalTime -> LocalTimeMilliC;

#ifdef RADIO_DEBUG
	components DiagMsgC, new TimerMilliC(), MainC;
	TrafficMonitorLayerP.DiagMsg -> DiagMsgC;
	TrafficMonitorLayerP.Timer -> TimerMilliC;
	TrafficMonitorLayerP.Boot -> MainC;
#endif
}
