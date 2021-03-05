#!/bin/bash

# Guess if this is going to succeed
/home/ubuntu/divs-midi-utilities/bin/lsmidiins | grep "1 " >/dev/null && echo "MIDI Interface exists" || sleep 1

/home/ubuntu/divs-midi-utilities/bin/brainstorm --in 1 --prefix session_ --timeout 10 --confirmation "/home/ubuntu/midi-utils/after_save.sh -f %s"