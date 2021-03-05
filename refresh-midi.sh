#!/bin/sh

/home/ubuntu/divs-midi-utilities/bin/lsmidiins | grep "reface" >/dev/null && echo "Reface exists" || sudo systemctl restart brainstorm