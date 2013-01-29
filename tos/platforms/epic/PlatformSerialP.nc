module PlatformSerialP {
  provides interface StdControl;
  provides interface Msp430UartConfigure;
  uses interface Resource;
}
implementation {
    enum {
        // from http://www.daycounter.com/Calculators/MSP430-Uart-Calculator.phtml
        UBR_4MHZ_4800=0x0369,   UMCTL_4MHZ_4800=0xfb,
        UBR_4MHZ_9600=0x01b4,   UMCTL_4MHZ_9600=0xdf,
        UBR_4MHZ_57600=0x0048,  UMCTL_4MHZ_57600=0xfb,
        UBR_4MHZ_115200=0x0024, UMCTL_4MHZ_115200=0x29,
        UBR_3_7MHZ_115200=0x0020, UMCTL_3_7MHZ_115200=0x00,
    };   
    
    const msp430_uart_union_config_t msp430_uart_epic_config = { {
        ubr  : UBR_4MHZ_115200,
        umctl: UBR_4MHZ_115200,
        ssel: 0x02, pena: 0, pev: 0, spb: 0, clen: 1, listen: 0, mm: 0,
        ckpl: 0, urxse: 0, urxeie: 1, urxwie: 0, utxe : 1, urxe : 1
    } };

    command error_t StdControl.start(){
        return call Resource.immediateRequest();
    }

    command error_t StdControl.stop(){
        call Resource.release();
        return SUCCESS;
    }

    event void Resource.granted(){}

    async command const msp430_uart_union_config_t* Msp430UartConfigure.getConfig() {
        return &msp430_uart_epic_config;
    }
}
