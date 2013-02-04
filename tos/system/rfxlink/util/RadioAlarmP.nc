#include <Tasklet.h>
#include <RadioAssert.h>
#include "RadioConfig.h"

generic module RadioAlarmP()
{
	provides
	{
		interface RadioAlarm[uint8_t id];
	}

	uses
	{
		interface Alarm<TRadio, tradio_size>;
		interface Tasklet;
	}
}

implementation
{
	norace uint8_t state;
	enum
	{
		STATE_READY = 0,
		STATE_WAIT = 1,
		STATE_FIRED = 2,
	};

	tasklet_norace uint8_t alarm;

	async event void Alarm.fired()
	{
		atomic
		{
			if( state == STATE_WAIT )
				state = STATE_FIRED;
		}

		call Tasklet.schedule();
	}

	inline async command tradio_size RadioAlarm.getNow[uint8_t id]()
	{
		return call Alarm.getNow();
	}

	tasklet_async event void Tasklet.run()
	{
		if( state == STATE_FIRED )
		{
			state = STATE_READY;
			signal RadioAlarm.fired[alarm]();
		}
	}

	default tasklet_async event void RadioAlarm.fired[uint8_t id]()
	{
	}

	inline tasklet_async command bool RadioAlarm.isFree[uint8_t id]()
	{
		return state == STATE_READY;
	}

	tasklet_async command void RadioAlarm.wait[uint8_t id](tradio_size timeout)
	{
		RADIO_ASSERT( state == STATE_READY );

		alarm = id;
		state = STATE_WAIT;
		call Alarm.start(timeout);
	}

	tasklet_async command void RadioAlarm.cancel[uint8_t id]()
	{
		RADIO_ASSERT( alarm == id );
		RADIO_ASSERT( state != STATE_READY );

		call Alarm.stop();
		state = STATE_READY;
	}
}
