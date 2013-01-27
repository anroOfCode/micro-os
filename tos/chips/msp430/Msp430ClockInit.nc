interface Msp430ClockInit
{
  event void setupDcoCalibrate();
  event void initClocks();
  event void initTimerA();
  event void initTimerB();

  command void defaultSetupDcoCalibrate();
  command void defaultInitClocks();
  command void defaultInitTimerA();
  command void defaultInitTimerB();
}

