#!/bin/sh

/bin/killall access_mtd
/bin/killall rlog
/bin/killall mydlink-watch-dog.sh
/bin/killall signalc
/bin/killall mylogd
/bin/killall avahi-daemon
/usr/sbin/maild stop
/usr/sbin/p2p.sh stop



