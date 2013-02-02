/*
 * Copyright (c) 2007-2009, Vanderbilt University
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the copyright holder nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Author: Miklos Maroti
 */

generic module Ieee154MessageLayerC()
{
    provides 
    {
        interface BareSend as Send;
        interface BareReceive as Receive;
    }

    uses
    {
        interface BareSend as SubSend;
        interface BareReceive as SubReceive;
    }
}

implementation
{

/*----------------- Ieee154Send -----------------*/


    command error_t Send.cancel(message_t* msg)
    {
        return call SubSend.cancel(msg);
    }

    command error_t Send.send(message_t* msg)
    {
        return call SubSend.send(msg);
    }

    event void SubSend.sendDone(message_t* msg, error_t error)
    {
        signal Send.sendDone(msg, error);
    }

    default event void Send.sendDone(message_t* msg, error_t error)
    {
    }

/*----------------- Receive -----------------*/

    event message_t* SubReceive.receive(message_t* msg)
    {
        return signal Receive.receive(msg);
    }

    default event message_t* Receive.receive(message_t* msg)
    {
        return msg;
    }
}
