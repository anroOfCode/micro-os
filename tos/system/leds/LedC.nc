#include "PlatformLed.h"

/**
 * Provide access to the Led components available on this platform.
 * LEDs are made available positionally (e.g., Led0) and by color
 * (e.g., Green).
 *
 * @author Peter A. Bigot <pab@peoplepowerco.com>
 */
configuration LedC {
  provides {
#if 0 < PLATFORM_LED_COUNT
    interface Led as Led0;
#if 1 < PLATFORM_LED_COUNT
    interface Led as Led1;
#if 2 < PLATFORM_LED_COUNT
    interface Led as Led2;
#if 3 < PLATFORM_LED_COUNT
    interface Led as Led3;
#if 4 < PLATFORM_LED_COUNT
    interface Led as Led4;
#if 5 < PLATFORM_LED_COUNT
    interface Led as Led5;
#if 6 < PLATFORM_LED_COUNT
    interface Led as Led6;
#if 7 < PLATFORM_LED_COUNT
    interface Led as Led7;
#endif // count 7
#endif // count 6
#endif // count 5
#endif // count 4
#endif // count 3
#endif // count 2
#endif // count 1
#endif // count 0
#if defined(PLATFORM_LED_GREEN)
    interface Led as Green;
#endif // GREEN
#if defined(PLATFORM_LED_RED)
    interface Led as Red;
#endif // RED
#if defined(PLATFORM_LED_WHITE)
    interface Led as White;
#endif // WHITE
#if defined(PLATFORM_LED_YELLOW)
    interface Led as Yellow;
#endif // YELLOW
#if defined(PLATFORM_LED_ORANGE)
    interface Led as Orange;
#endif // ORANGE
#if defined(PLATFORM_LED_BLUE)
    interface Led as Blue;
#endif // BLUE
    interface MultiLed;
  }
} implementation {
  components PlatformLedC;
  MultiLed = PlatformLedC;

  /* Define the positional LEDs */
#if 0 < PLATFORM_LED_COUNT
  Led0 = PlatformLedC.Led[0];
#if 1 < PLATFORM_LED_COUNT
  Led1 = PlatformLedC.Led[1];
#if 2 < PLATFORM_LED_COUNT
  Led2 = PlatformLedC.Led[2];
#if 3 < PLATFORM_LED_COUNT
  Led3 = PlatformLedC.Led[3];
#if 4 < PLATFORM_LED_COUNT
  Led4 = PlatformLedC.Led[4];
#if 5 < PLATFORM_LED_COUNT
  Led5 = PlatformLedC.Led[5];
#if 6 < PLATFORM_LED_COUNT
  Led6 = PlatformLedC.Led[6];
#if 7 < PLATFORM_LED_COUNT
  Led7 = PlatformLedC.Led[7];
#endif // count 7
#endif // count 6
#endif // count 5
#endif // count 4
#endif // count 3
#endif // count 2
#endif // count 1
#endif // count 0

  /* Define the color-specific LEDs */
#if defined(PLATFORM_LED_GREEN)
  Green = PlatformLedC.Led[PLATFORM_LED_GREEN];
#endif // GREEN
#if defined(PLATFORM_LED_RED)
  Red = PlatformLedC.Led[PLATFORM_LED_RED];
#endif // RED
#if defined(PLATFORM_LED_WHITE)
  White = PlatformLedC.Led[PLATFORM_LED_WHITE];
#endif // WHITE
#if defined(PLATFORM_LED_YELLOW)
  Yellow = PlatformLedC.Led[PLATFORM_LED_YELLOW];
#endif // YELLOW
#if defined(PLATFORM_LED_ORANGE)
  Orange = PlatformLedC.Led[PLATFORM_LED_ORANGE];
#endif // ORANGE
#if defined(PLATFORM_LED_BLUE)
  Blue = PlatformLedC.Led[PLATFORM_LED_BLUE];
#endif // BLUE
}
