#!/bin/bash
set -e

p4dctl start ${P4_SERVER_ID}
exec tail -f /opt/perforce/servers/${P4_SERVER_ID}/logs/log
