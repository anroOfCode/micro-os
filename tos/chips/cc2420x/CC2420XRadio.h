#ifndef __CC2420XRADIO_H__
#define __CC2420XRADIO_H__

#include <RadioConfig.h>
#include <Ieee154PacketLayer.h>
#include <MetadataFlagsLayer.h>
#include <CC2420XDriverLayer.h>
#include <LowPowerListeningLayer.h>
#include <PacketLinkLayer.h>

typedef nx_struct cc2420xpacket_header_t
{
	cc2420x_header_t cc2420x;
	ieee154_simple_header_t ieee154;
} cc2420xpacket_header_t;

typedef nx_struct cc2420xpacket_footer_t
{
} cc2420xpacket_footer_t;

typedef struct cc2420xpacket_metadata_t
{
#ifdef LOW_POWER_LISTENING
	lpl_metadata_t lpl;
#endif
#ifdef PACKET_LINK
	link_metadata_t link;
#endif
	flags_metadata_t flags;
	cc2420x_metadata_t cc2420x;
} cc2420xpacket_metadata_t;

#endif//__CC2420XRADIO_H__
