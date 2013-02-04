generic configuration UniqueLayerC()
{
	provides
	{
		// NOTE, this is a combined layer, should be hooked up at two places
		interface BareSend as Send;
		interface RadioReceive;
	}
	uses
	{
		interface BareSend as SubSend;
		interface RadioReceive as SubReceive;

		interface UniqueConfig as Config;
	}
}

implementation
{
	components new UniqueLayerP(), MainC, NeighborhoodC, new NeighborhoodFlagC();

	MainC.SoftwareInit -> UniqueLayerP;
	UniqueLayerP.Neighborhood -> NeighborhoodC;
	UniqueLayerP.NeighborhoodFlag -> NeighborhoodFlagC;

	Send = UniqueLayerP;
	SubSend = UniqueLayerP;

	RadioReceive = UniqueLayerP;
	SubReceive = UniqueLayerP;
	Config = UniqueLayerP;
}
