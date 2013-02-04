generic configuration RandomCollisionLayerC()
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
		interface RadioAlarm;

		interface RandomCollisionConfig as Config;
	}
}

implementation
{
	components new RandomCollisionLayerP(), RandomC;

	RadioSend = RandomCollisionLayerP;
	SubSend = RandomCollisionLayerP;
	Config = RandomCollisionLayerP;
	RadioReceive = RandomCollisionLayerP;
	SubReceive = RandomCollisionLayerP;
	RadioAlarm = RandomCollisionLayerP;

	RandomCollisionLayerP.Random -> RandomC;
}
