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

Any code I've used could very well belong to a different author. I claim no rights
and the original authors still reserve all their original rights. 

Some Goals
----------
  * Create a concise, lightweight implementation that reuses the useful
parts of TinyOS and discards the rest.
  * Support a clean IPv6 (BLIP) networking stack
  * Support the Epic platform, while using interfaces that make it simple
(but not too simple) to add others.

Some Non Goals
--------------
  * Support ActiveMessage
  * Create a generic, highly scalable, completely decoupled, fully abstracted,
but impossible to understand pile of awful, concept-count heavy code.