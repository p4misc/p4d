#!/bin/bash
set -e

P4ROOT=/opt/perforce/p4root
P4LOG=log
P4PORT=ssl:1666
export P4SSLDIR=$P4ROOT/ssl

chmod go-rwx $P4SSLDIR
/opt/perforce/sbin/p4d -Gc
/opt/perforce/sbin/p4d -r $P4ROOT -p $P4PORT -L $P4LOG -C1 -xi
/opt/perforce/sbin/p4d -r $P4ROOT -p $P4PORT -L $P4LOG -C1 -d
exec tail -f /opt/perforce/p4root/log
