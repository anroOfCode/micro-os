#ifndef __PACKETLINKLAYER_H__
#define __PACKETLINKLAYER_H__

typedef struct link_metadata_t
{
	uint16_t maxRetries;
	uint16_t retryDelay;
} link_metadata_t;

#endif//__PACKETLINKLAYER_H__
