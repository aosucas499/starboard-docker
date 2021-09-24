#!/bin/bash

SERVICES="/bin/dbus-uuidgen --ensure;/bin/dbus-daemon --system --fork;/etc/init.d/starboardservice start;/usr/local/lsadrv/bin/lsadrv_applet_install.sh; bash -x"

rm -f /var/run/dbus/pid > /dev/null 2>&1
sleep 1

IFS=';'

for s in $SERVICES; do
    echo $s
    screen -d -m bash -x -c $s
done

export LANG=es_ES.UTF-8

/usr/local/StarBoardSoftware/StarBoard.sh

