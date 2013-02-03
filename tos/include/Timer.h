#ifndef TIMER_H
#define TIMER_H

// @note TSecond is an extension to be added in a successor to TEP 102
typedef struct { int notUsed; } TSecond;
typedef struct { int notUsed; } TMilli;
typedef struct { int notUsed; } T32khz;
typedef struct { int notUsed; } TMicro;

#define UQ_TIMER_SECOND "HilTimerMicroC.Timer"
#define UQ_TIMER_MILLI "HilTimerMilliC.Timer"
#define UQ_TIMER_32KHZ "HilTimer32khzC.Timer"
#define UQ_TIMER_MICRO "HilTimerMicroC.Timer"

#endif

