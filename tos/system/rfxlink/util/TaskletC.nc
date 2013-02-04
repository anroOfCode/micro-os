#include <Tasklet.h>
#include <RadioAssert.h>

module TaskletC
{
	provides interface Tasklet;
}

implementation
{
#ifdef TASKLET_IS_TASK

	task void tasklet()
	{
		signal Tasklet.run();
	}

	inline async command void Tasklet.schedule()
	{
		post tasklet();
	}

	inline command void Tasklet.suspend()
	{
	}

	inline command void Tasklet.resume()
	{
	}

#else
	
	/**
	 * The lower 7 bits contain the number of suspends plus one if the run 
	 * event is currently beeing executed. The highest bit is set if the run 
	 * event needs to be called again when the suspend count goes down to zero.
	 */
	uint8_t state;

	void doit()
	{
		for(;;)
		{
			signal Tasklet.run();

			atomic
			{
				if( state == 1 )
				{
					state = 0;
					return;
				}

				RADIO_ASSERT( state == 0x81 );
				state = 1;
			}
		}
	}

	inline command void Tasklet.suspend()
	{
		atomic ++state;
	}

	command void Tasklet.resume()
	{
		atomic
		{
			if( --state != 0x80 )
				return;

			state = 1;
		}

		doit();
	}

	async command void Tasklet.schedule()
	{
		atomic
		{
			if( state != 0 )
			{
				state |= 0x80;
				return;
			}

			state = 1;
		}

		doit();
	}

#endif
}
