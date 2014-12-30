#!/bin/bash
nzbget -s
sleep 2
NZBPID=`cat /var/run/nzbget.pid`
echo "NZBGet PID: $NZBPID"
trap "echo ' => Please wait, gracefully stopping nzbget...' && kill $NZBPID >/dev/null 2>&1 && wait $NZBPID" TERM INT
wait $NZBPID
