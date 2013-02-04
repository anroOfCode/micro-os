#ifndef __RADIOCONFIG_H__
#define __RADIOCONFIG_H__

#include <Timer.h>
#include <CC2420XDriverLayer.h>
//#include <util/crc16.h>

/* This is the default value of the PA_POWER field of the TXCTL register. */
#ifndef CC2420X_DEF_RFPOWER
#define CC2420X_DEF_RFPOWER	0
#endif

/* This is the default value of the CHANNEL field of the FSCTRL register. */
#ifndef CC2420X_DEF_CHANNEL
#define CC2420X_DEF_CHANNEL	11
#endif

#define LOW_POWER_LISTENING

#define SOFTACK_TIMEOUT	2500

#define LPL_DELAY_AFTER_RECEIVE 100
#define LPL_LOCAL_WAKEUP 0 // 500ms Interval
#define LPL_LISTEN_LENGTH 5 // 5ms Listen for 1% of that

#define RCA_MIN_BACKOFF 320
#define RCA_INIT_BACKOFF 4960
#define RCA_CONG_BACKOFF 2240

/**
 * This is the timer type of the radio alarm interface
 */
typedef TMicro TRadio;
typedef uint16_t tradio_size;

/**
 * The number of radio alarm ticks per one microsecond (0.9216).
 * We use integers and no parentheses just to make deputy happy.
 * Ok, further hacks were required for deputy, I removed 00 from the
 * beginning and end to be able to handle longer wait periods.
 */
#define RADIO_ALARM_MICROSEC	1

/**
 * The base two logarithm of the number of radio alarm ticks per one millisecond
 */
#define RADIO_ALARM_MILLI_EXP	10

#endif//__RADIOCONFIG_H__
