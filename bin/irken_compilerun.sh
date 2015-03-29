#!/bin/bash

set -ue

IGNORE_BUILD_EXIT_CODE=true
SOURCE=${!#}

BIN=`echo $SOURCE | sed 's/\.scm$//'`

echo =============================[BUILDING]==================================
if ! irken "$@" "$SOURCE" ; then
    if ! $IGNORE_BUILD_EXIT_CODE ; then
        >&2 echo "Build exited with non-zero exit code."
        exit 1
    fi
fi
echo =============================[RUNNING]==================================
if [ ! -r "$BIN" ] ; then
    >&2 echo "Binary file '$BIN' missing."
    exit 1
fi
"$BIN"
