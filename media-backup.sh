#!/bin/bash

PAR_REDUNDANCY=20

# do a dry run by default
if [ -z ${MEDIABACKUP_NODRYRUN+x} ]
    echo ""
    echo "¡¡WARNING!! Only doing a dry run ¡¡WARNING!!"
    echo ""
    export BACKUP_DRYRUN=--dry-run
then
else
    echo ""
    echo "¡¡WARNING!! Doing a real backup run ¡¡WARNING!!"
    echo ""
fi

# check if we are backing up to an external HDD, mount must be defined
# in environment variable HOMEBACKUP_DEST
if [ -z ${MEDIABACKUP_DEST+x} ]
then
    export BACKUP_DEST=/var/backups/media-backup
    mkdir -p $MEDIABACKUP_DEST
fi

if [ ! -d $MEDIABACKUP_DEST ]
then
    >&2 echo "External HDD not mounted"
    exit 1
fi

cd $HOME

echo "Backing up from $(pwd) to $MEDIABACKUP_DEST/media-backup/"
echo ""

duplicity --no-encryption --no-compression --log-file /var/log/media-backup/media-backup.log --asynchronous-upload --progress $BACKUP_DRYRUN --par2-redundancy=$PAR_REDUNDANCY --include-filelist ./Backup/media-backup/media-backup.includes . file://$MEDIABACKUP_DEST/media-backup
