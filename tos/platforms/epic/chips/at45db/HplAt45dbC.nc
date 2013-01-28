configuration HplAt45dbC {
    provides interface HplAt45db;
}
implementation {

    components new HplAt45dbByteC(10),
    new Msp430Spi0C() as Spi,
    HplAt45dbP,
    HplMsp430GeneralIOC as MspGeneralIO,
    new Msp430GpioC() as Select;

    HplAt45db = HplAt45dbByteC;

    HplAt45dbByteC.Resource -> Spi;
    HplAt45dbByteC.FlashSpi -> Spi;
    HplAt45dbByteC.HplAt45dbByte -> HplAt45dbP;

    Select -> MspGeneralIO.Port44;
    HplAt45dbP.Select -> Select;
    HplAt45dbP.FlashSpi -> Spi;
}
