home-backup
===========

This repository holds files needed for home directory backup based on
[duplicity][1]

This script is just meant to make it easy for me to run backup of entire home
directory, which is less than 100G if excluded properly.

Using duplicity makes it easier to do data recovery on a failed HDD too, as
you don't need to fully-encrypt the disk, instead duplicity will encrypt the
backup, as well as create extra PAR2 recovery volumes.

The `./home-backup.excludes` file has some sane hidden files excludes, plus
some large media directories which should not be backed up.

The `./media-backup.includes` file excludes everything and only includes a few
select directories. It does not use encryption nor compression.

To prevent things going nuts on other people's systems I have set the scripts
to only do dry-runs.

*Published only for educational purposes.*

I have this in my `~/.zshrc.d/home-backup.zsh`

```
# settings for http://github.com/conrado/home-backup

export HOMEBACKUP_NODRYRUN=1
export HOMEBACKUP_DEST=/media/conrado/home-backup

export MEDIABACKUP_NODRYRUN=1
export MEDIABACKUP_DEST=/media/conrado/media-backup
```

[1]: http://duplicity.nongnu.org/
