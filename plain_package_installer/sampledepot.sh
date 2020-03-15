#!/bin/bash

if [ "${P4_SAMPLE_DEPOT}" = "" ]; then
  exit 0
fi

P4ROOT=/opt/perforce/servers/${P4_SERVER_ID}/root

if [ "${P4_CASE}" -eq "0" ]; then
  cd /opt/perforce
  wget -q http://ftp.perforce.com/pub/perforce/tools/sampledepot.tar.gz
  tar xzf sampledepot.tar.gz
else
  cd /opt/perforce
  wget -q http://ftp.perforce.com/pub/perforce/tools/sampledepot.zip
  unzip -q sampledepot.zip
fi

cd ${P4ROOT}
chown -R perforce:perforce /opt/perforce/PerforceSample
rm -f  db.*
rm -rf ../archives/*
rm -f  ../journals/*
rm -f  ../logs/*
mv /opt/perforce/PerforceSample/checkpoint .
mv /opt/perforce/PerforceSample/* ../archives
rm -rf /opt/perforce/PerforceSample

/opt/perforce/sbin/p4d -r . -C${P4_CASE} -jr checkpoint
/opt/perforce/sbin/p4d -r . -C${P4_CASE} -xu
/opt/perforce/sbin/p4d -r . -C${P4_CASE} -xi
/opt/perforce/sbin/p4d -r . -C${P4_CASE} "-cset journalPrefix=../journals/commit"
/opt/perforce/sbin/p4d -r . -C${P4_CASE} "-cset P4JOURNAL=../journals/journal"
/opt/perforce/sbin/p4d -r . -C${P4_CASE} "-cset server.depot.root=../archives"
/opt/perforce/sbin/p4d -r . -C${P4_CASE} "-cset P4LOG=../logs/log"
/opt/perforce/sbin/p4d -r . -C${P4_CASE} "-cset serverlog.file.1=../logs/commands.csv"
/opt/perforce/sbin/p4d -r . -C${P4_CASE} "-cset serverlog.file.2=../logs/errors.csv"
/opt/perforce/sbin/p4d -r . -C${P4_CASE} "-cset serverlog.file.3=../logs/events.csv"
/opt/perforce/sbin/p4d -r . -C${P4_CASE} "-cset serverlog.file.4=../logs/integrity.csv"
/opt/perforce/sbin/p4d -r . -C${P4_CASE} "-cset serverlog.file.5=../logs/auth.csv"
