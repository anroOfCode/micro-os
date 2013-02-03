generic configuration AsyncStdControlPowerManagerC()
{
  uses {
    interface AsyncStdControl;

    interface PowerDownCleanup;
    interface ResourceDefaultOwner;
    interface ArbiterInfo;
  }
}
implementation {
  components new AsyncPowerManagerP() as PowerManager;
 
  PowerManager.AsyncStdControl = AsyncStdControl;

  PowerManager.PowerDownCleanup = PowerDownCleanup;
 
  PowerManager.ResourceDefaultOwner = ResourceDefaultOwner;
  PowerManager.ArbiterInfo = ArbiterInfo;
}

