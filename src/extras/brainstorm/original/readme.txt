
Brainstorm
Copyright 2000-2012 David G. Slomin
Brainstorm is Free Software provided under terms of the BSD licence

Brainstorm is a small program for recording MIDI data.  It has no user
interface at all; rather it automatically decides when to start and stop 
recording, when to save files, and what to name them.  This is similar in 
concept to a dictation machine.  

Because it is very lightweight and has no interface, Brainstorm can be run 
as a daemon at all times.  That way, you never have to consciously start up 
a sequencer to capture a great new idea when you're brainstorming.  This, of
course, is the origin of its name.

Brainstorm takes three arguments on the command line: the name of the
MIDI input device (or FIFO), a filename prefix, and a timeout.  
Brainstorm stores all incoming MIDI events in a buffer in memory.  If
it senses that there have been no new MIDI events for <timeout> seconds, 
it writes the buffer to a standard MIDI file named 
<prefix>.<year>.<month>.<day>.<hour>.<minute>.<second>.mid .

Brainstorm does not provide a metronome; notes will almost certainly not 
line up with measures, but they will play back sounding the same as you 
played them.

Brainstorm was developed on Linux using the standard free OpenSound driver,
but should work with ALSA or any other Posix compatible operating system that 
supports raw MIDI streams.

Div Slomin 
4 February 2002

