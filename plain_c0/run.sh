#!/bin/bash
set -e

P4ROOT=/opt/perforce/p4root
P4LOG=log
P4PORT=1666

/opt/perforce/sbin/p4d -r $P4ROOT -xi
/opt/perforce/sbin/p4d -r $P4ROOT -p $P4PORT -L $P4LOG -d
exec tail -f /opt/perforce/p4root/log
