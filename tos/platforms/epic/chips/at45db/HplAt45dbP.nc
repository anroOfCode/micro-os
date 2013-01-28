module HplAt45dbP {
    provides {
        interface HplAt45dbByte;
    }
    uses {
        interface SpiByte as FlashSpi;
        interface GeneralIO as Select;
    }
}
implementation
{
    command void HplAt45dbByte.select() {
        call Select.clr();
    }

    command void HplAt45dbByte.deselect() {
        call Select.set();
    }

    task void idleTask() {
        uint8_t status;
        status = call FlashSpi.write(0);
        if (!(status & 0x80)) {
            post idleTask();
        } else {
            signal HplAt45dbByte.idle();
        }
    }

    command void HplAt45dbByte.waitIdle() {
        post idleTask();
    }

    command bool HplAt45dbByte.getCompareStatus() {
        uint8_t status;
        status = call FlashSpi.write(0);
        return (!(status & 0x40));
    }
}
