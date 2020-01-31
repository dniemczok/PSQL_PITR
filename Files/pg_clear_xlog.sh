#!/bin/bash

DATA=`date +"%Y-%m-%d"`
# DATET=`date +"%Y-%m-%d_%H-%M"`

pg_basebackup -Ft -D /var/lib/postgresql/BKP/$DATE
# pg_basebackup -Ft -D /var/lib/postgresql/BKP/$DATET

ARCHIVEDIR='/var/lib/postgresql/XLOG'
CHKPOINT=$(find $ARCHIVEDIR -type f -mtime +1 -name '*backup' -printf '%f\n' | sort -r | head -1)
# Starsze niż minuta
# CHKPOINT=$(find $ARCHIVEDIR -type f -amin +1 -name '*backup' -printf '%f\n' | sort -r | head -1)

cd $ARCHIVEDIR
/usr/bin/pg_archivecleanup $ARCHIVEDIR $CHKPOINT
