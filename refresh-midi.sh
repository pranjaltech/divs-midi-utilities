#!/bin/sh

/home/ubuntu/divs-midi-utilities/bin/lsmidiins | grep "1 " >/dev/null && echo "MIDI Interface exists" || sudo systemctl restart brainstorm