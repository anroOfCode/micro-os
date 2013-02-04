module NoLedsC {
  provides interface Init;
  provides interface Leds;
}
implementation {

  command error_t Init.init() {return SUCCESS;}

  async command void Leds.led0On() {}
  async command void Leds.led0Off() {}
  async command void Leds.led0Toggle() {}

  async command void Leds.led1On() {}
  async command void Leds.led1Off() {}
  async command void Leds.led1Toggle() {}

  async command void Leds.led2On() {}
  async command void Leds.led2Off() {}
  async command void Leds.led2Toggle() {}

  async command uint8_t Leds.get() {return 0;}
  async command void Leds.set(uint8_t val) {}
}
