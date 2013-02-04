#ifndef __TASKLET_H__
#define __TASKLET_H__

#ifdef	TASKLET_IS_TASK

	#define tasklet_async
	#define tasklet_norace

#else

	#define tasklet_async	async	
	#define tasklet_norace	norace

#endif

#endif//__TASKLET_H__
