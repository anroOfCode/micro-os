#ifndef __RADIOASSERT_H__
#define __RADIOASSERT_H__

#ifdef RADIO_DEBUG

	void assert(bool condition, const char* file, uint16_t line);
	#define RADIO_ASSERT(COND) assert(COND, __FILE__, __LINE__)

#else

	#define RADIO_ASSERT(COND) for(;0;)

#endif

#endif//__RADIOASSERT_H__
