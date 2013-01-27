configuration MoteClockC
{
  provides interface Init as MoteClockInit;
}
implementation

{
  components Msp430ClockC, MoteClockP;
  
  MoteClockInit = Msp430ClockC.Init;
}
