module NullC @safe()
{
  uses interface Boot;
}
implementation
{
  event void Boot.booted() {
    // Do nothing.
  }
}

