generic configuration NeighborhoodFlagC()
{
	provides interface NeighborhoodFlag;
}

implementation
{
	components NeighborhoodP;

	// TODO: make sure that no more than 8 flags are used at a time
	NeighborhoodFlag = NeighborhoodP.NeighborhoodFlag[unique("NeighborhoodFlag")];
}
