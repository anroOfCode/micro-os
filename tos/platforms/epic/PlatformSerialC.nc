configuration PlatformSerialC {
    provides interface StdControl;
    provides interface UartStream;
    provides interface UartByte;
}

implementation {
    components new Msp430Uart1C() as UartC;
    UartStream = UartC;  
    UartByte = UartC;
    
    components PlatformSerialP;
    StdControl = PlatformSerialP;
    PlatformSerialP.Msp430UartConfigure <- UartC.Msp430UartConfigure;
    PlatformSerialP.Resource -> UartC.Resource;
}
