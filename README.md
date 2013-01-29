micro-os
========

An experiment into what a slimmed down version of TinyOS would look like.

TinyOS has become very bloated with both dead, unused, and unusable code. This
is very frustrating. It's not clear where one unnecessary abstraction begins
and the other ends, or which ones are needed, or even what code is actually
compiled into the final binary.

I'm curious what a version of TinyOS would look like with all the cruft removed.
To this end I'm playing around with the idea of a version of TinyOS without all
the unused code, focusing on supporting a small number of platforms and trimming
the fat out of some of the dare I say ridiculous abstractions and interfaces that
have been layered on top of what used to be simple microcontrollers.

**Any code I've used could very well belong to a different author. I claim no rights
or authorship to the code (with the exception being code I've written or rewritten)
and the original authors still reserve all their original rights.**

**Some Goals**

  * Create a concise, lightweight implementation that reuses the useful
parts of TinyOS and discards the rest.
  * Support a clean IPv6 (BLIP) networking stack
  * Support the Epic platform, while using interfaces that make it simple
(but not too simple) to add others.

**Some Non Goals**

  * Support ActiveMessage
  * Create a generic, highly scalable, completely decoupled, fully abstracted,
but impossible to understand pile of awful, concept-count heavy code.

Current Status and Road Map
---------------------------
Currently micro-os supports the basic Blink app for the Epic platform. It
sports a trimmed-down system directory and a slightly better organizational
structure.

Here's the roadmap for micro-os:
  * Bring support for the AT45DB flash chip back into the build
  * Bring support for the identification chip back into the build
  * Take a long, hard look at how the CC2420 is implemented and trim
as much from it as possible. Move to the rfxlink implementation
and remove all support for ActiveMessage
  * Write some raw 802.15.4 send/receive applications that test core
radio functionality.
  * Take a look at BLIP. It's going to be a little trickier to get
this implemented, it has a pretty interesting build process. Add
support for it.

Folder Layout
-------------
We've diverged a little bit from the TinyOS folder layout. I tried to fix
a few of the oddities and inconsistencies.

  * tos\system - Main directory for all non-chip specific files. This includes
all of the glue code, the main scheduler, and other core system components. Each
core system module (defined as a set of TinyOS components and interfaces) is placed 
in its own separate folder within this directory. 
  * tos\interfaces - Any interfaces that are used across multiple modules, or are
designed for general purpose use are placed here.
  * tos\include - All header files are to be placed here. 
  * tos\platforms - Each platform has a separate directory that contains platform-specific
components. This can include wiring of chips to certain IO pins, definition of hardware
modules to include, and initialization code. 
  * tos\chips - Every chip (both peripheral and microcontroller) should have a directory
here that contains the code necessary to interface successfully with it and any interfaces
it exports. In theory chips should have hardware presentation layers and hardware abstraction
layers defined, but as long as things are reasonable modular you're doing just fine. 
  * tools - Includes the tos-bsl tool for programming motes, and a
modified version of ncc, the TinyOS wrapper around the nesC compiler. TinyOS specific
tools should be placed here. 
  * support\make - The make system resides here, including .target files that help
TinyOS determine which tool chain and platform directory to inspect to compile for
a specific platform, as well as how to build and install the resultant binaries.

**Some Divergences from TinyOS**

The big change I'm making in the folder layout are the elimination of the lib directory,
and the breaking up of the system directory into subfolders.

What I Hope To Build
--------------------

What is the ultimate goal behind micro-os? Well there's a couple. The more
significant goal here is to build something that is stable, clean, and works
well. TinyOS is really great, especially for a research platform, but falls
short when one wants to actually build a production sensor network.

My hopes are that micro-os will become a good building block for those wishing
to actually create 6lowpan/RPL compliant sensor networks. A lot of good research
and work has gone into creating some documents we can standardize around, yet
few good implementations of these standards exist, and even fewer working
networks.

micro-os will support the Epic platform, which is a nice open-source design
sporting a CC2420 radio, a MSP430 microcontroller, and some onboard storage.
It will support a multi-hop IPv6 stack, and it will be flexible enough that
one can easily add sensors and other code to the platform to build
functional measuring motes. 

You should be able to take this code one day, program a couple hundred motes,
install a base station (see my work on a CC2520 driver for the raspberry pi),
and be up and running with an industrial-grade sensor network.

It should serve as a stepping stone for research and products that are not
rooted in designing a wireless sensor network, but assume it's existence and
instead focus on the specifics of applications running atop them.

A Note On Code Style
--------------------
This project will follow K&R style. We will be using four-space tabs on all new code.

Old TinyOS code uses two spaces. I don't like this and will reindent code as I see
fit.

Reasons Why This Needed To Happen
---------------------------------
  * TinyOS's printf library requires a long, complicated wiki page with flow charts
and diagrams to use and some awful Java ActiveMessage demuxing program and is an
absolute headache to understand.
  * The implementation of the ds2411 required 11 separate files, 2 of which were
just dead code laying around to confuse.

