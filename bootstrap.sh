#!/usr/bin/env bash

BOOTSTRAP=$0
DOTFILES_ROOT=$PWD
BACKUP_DIR=$HOME/.backup-`date +%Y%m%d-%H%M%S`

echo Create backup directory: $BACKUP_DIR
mkdir -p $BACKUP_DIR

for SRC in $(ls $DOTFILES_ROOT | sed -e "/$(basename $BOOTSTRAP)/d"); do
    echo $SRC
    DST=$HOME/.$SRC
    if [ -L $DST ]; then
        echo unlink $DST
        unlink $DST
    elif [ -e $DST ]; then
        echo mv $DST $BACKUP_DIR
        mv $DST $BACKUP_DIR
    fi
    echo ln -s $DOTFILES_ROOT/$SRC $DST
    ln -s $DOTFILES_ROOT/$SRC $DST
done

