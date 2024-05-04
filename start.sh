#!/bin/bash

rm /run/dbus/pid
dbus-daemon --config-file=/usr/share/dbus-1/system.conf
avahi-daemon &

sleep 10

while IFS="" read -r p
do
    if [[ $p =~ ^[A-Z|a-z]+\=\>[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo $p
        REPL=(${p//=>/ })
        NAME=${REPL[0]}
        IP=${REPL[1]}

        avahi-publish -a "$NAME.local" -R "$IP" &
    fi
done

sleep infinity