#!/usr/bin/env bash

BOOTSTRAP=$0
DOTFILES_ROOT=$PWD
BACKUP_DIR=$HOME/.dotfiles-backup-`date +%Y%m%d-%H%M%S`

for SRC in $(ls $DOTFILES_ROOT | \
             sed -e "/$(basename $BOOTSTRAP)/d" \
                 -e "/LICENSE/d" \
                 -e "/README\.md/d" \
                 -e "/.*\.png/d");
do
    DST=$HOME/.$SRC
    if [ -L $DST ]; then
        unlink $DST
    elif [ -e $DST ]; then
        if [ ! -d $BACKUP_DIR ]; then
            echo -e "Create backup directory: $BACKUP_DIR"
            mkdir -p $BACKUP_DIR
        fi
        echo -e "mv $DST $BACKUP_DIR"
        mv $DST $BACKUP_DIR
    fi
    ln -s $DOTFILES_ROOT/$SRC $DST
done

echo -e "Done"

