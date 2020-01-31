#!/bin/bash

DATA=`date +"%Y-%m-%d"`
DATET=`date +"%Y-%m-%d_%H-%M"`
BKP_DIR='/var/lib/postgresql/BKP'
ARCHIVEDIR='/var/lib/postgresql/XLOG'

echo $DATET >> TMask_PG_BACKUP_LOG.log
echo $DATET >> TMask_history.log
history >> TMask_history.log
id >> TMask_PG_BACKUP_LOG.log
ls -ltr $ARCHIVEDIR >> TMask_PG_BACKUP_LOG.log

pg_basebackup -Ft -D $BKP_DIR/$DATE
# pg_basebackup -Ft -D $BKP_DIR/$DATET


CHKPOINT=$(find $ARCHIVEDIR -type f -mtime +1 -name '*backup' -printf '%f\n' | sort -r | head -1)
# Starsze niż minuta
# CHKPOINT=$(find $ARCHIVEDIR -type f -amin +1 -name '*backup' -printf '%f\n' | sort -r | head -1)

cd $ARCHIVEDIR
BACKUP='$BKP_DIR/$DATE'
if [ -d "$BACKUP" ]; then
    /usr/bin/pg_archivecleanup $ARCHIVEDIR $CHKPOINT
fi
