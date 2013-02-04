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

/* The number of microseconds a sending micaz mote will wait for an acknowledgement */
#ifndef SOFTWAREACK_TIMEOUT
#define SOFTWAREACK_TIMEOUT	800
#endif

#define LOW_POWER_LISTENING

#ifndef DELAY_AFTER_RECEIVE
#define LPL_DELAY_AFTER_RECEIVE 100
#endif

/**
 * The LPL defaults to stay-on.
 */
#ifndef LPL_DEF_LOCAL_WAKEUP
#define LPL_DEF_LOCAL_WAKEUP 0
#endif

#ifndef LPL_DEF_REMOTE_WAKEUP
#define LPL_DEF_REMOTE_WAKEUP 0
#endif

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
