generic configuration CsmaLayerC()
{
	provides
	{
		interface RadioSend;
		interface RadioReceive;
	}
	uses
	{
		interface RadioSend as SubSend;
		interface RadioReceive as SubReceive;
		interface RadioCCA as SubCCA;

		interface CsmaConfig as Config;
	}
}

implementation
{
	components new CsmaLayerP();

	RadioSend = CsmaLayerP;
	SubSend = CsmaLayerP;
	RadioReceive = SubReceive;
	SubCCA = CsmaLayerP;
	Config = CsmaLayerP;
}
