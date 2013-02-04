#include "RadioConfig.h"

generic configuration RadioAlarmC()
{
	provides
	{
		interface RadioAlarm[uint8_t id]; // use unique
	}

	uses
	{
		interface Alarm<TRadio, tradio_size> @exactlyonce();
	}
}

implementation
{
	components new RadioAlarmP(), TaskletC;

	RadioAlarm = RadioAlarmP;
	Alarm = RadioAlarmP;
	RadioAlarmP.Tasklet -> TaskletC;
}
