generic module AsyncPowerManagerP() @safe() {
  uses {
    interface AsyncStdControl;

    interface PowerDownCleanup;
    interface ResourceDefaultOwner;
    interface ArbiterInfo;
  }
}
implementation {

  async event void ResourceDefaultOwner.requested() {
    call AsyncStdControl.start();
    call ResourceDefaultOwner.release(); 
  }

  async event void ResourceDefaultOwner.immediateRequested() {
    call AsyncStdControl.start();
    call ResourceDefaultOwner.release();
  } 

  async event void ResourceDefaultOwner.granted() {
    call PowerDownCleanup.cleanup();
    call AsyncStdControl.stop();
  }

  default async command void PowerDownCleanup.cleanup() {
  }
}
