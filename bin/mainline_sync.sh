#!/bin/sh

set -ue

MODE="${1:-}"

NFS=/ws/miburr-sjc/git/mainline
LOCAL=~/git/mainline

if [ ! -d "$NFS" ] ; then
    >&2 echo "$NFS not present (not mounted?)"
    exit 1
fi

if [ `readlink -f $NFS` == `readlink -f $LOCAL` ] ; then
    >&2 echo `readlink -f $NFS` == `readlink -f $LOCAL`
    >&2 echo "Is your home dir NFS mounted?"
    exit 1
fi

CMD="rsync -xa --inplace --delete"

if [ "$MODE" == "tonfs" ] ; then
    $CMD "$LOCAL"/ "$NFS"/
elif [ "$MODE" == "fromnfs" ] ; then
    $CMD "$NFS"/ "$LOCAL"/
else
    >&2 echo "usage: `basename $0` <tonfs|fromnfs>"
    exit 1
fi
