configuration NeighborhoodC
{
	provides interface Neighborhood;
}

implementation
{
	components NeighborhoodP, MainC;

	Neighborhood = NeighborhoodP;
	MainC.SoftwareInit -> NeighborhoodP;
}
