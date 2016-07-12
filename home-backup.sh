#!/bin/bash

PAR_REDUNDANCY=20

# do a dry run by default
if [ -z ${HOMEBACKUP_NODRYRUN+x} ]
then
    echo ""
    echo "¡¡WARNING!! Only doing a dry run ¡¡WARNING!!"
    echo ""
    export BACKUP_DRYRUN=--dry-run
else
    echo ""
    echo "¡¡WARNING!! Doing a real backup run ¡¡WARNING!!"
    echo ""
fi

# check if we are backing up to an external HDD, mount must be defined
# in environment variable HOMEBACKUP_DEST
if [ -z ${HOMEBACKUP_DEST+x} ]
then
    export BACKUP_DEST=/var/backups/home-backup
    mkdir -p $HOMEBACKUP_DEST
fi

if [ ! -d $HOMEBACKUP_DEST ]
then
    >&2 echo "External HDD not mounted"
    exit 1
fi

cd $HOME

echo "Backing up from $(pwd) to $HOMEBACKUP_DEST/home-backup/"
echo ""

duplicity --log-file /var/log/home-backup/home-backup.log --asynchronous-upload --progress $BACKUP_DRYRUN --par2-redundancy=$PAR_REDUNDANCY --exclude-filelist ./Backup/home-backup/home-backup.excludes . file://$HOMEBACKUP_DEST/home-backup/
