#!/bin/bash

set -ue

IGNORE_BUILD_EXIT_CODES=( 14 )
SOURCE=${!#}
BIN=`echo $SOURCE | sed 's/\.scm$//'`

contains () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

if [ -r "$BIN" ] ; then
    rm -f "$BIN"
fi

echo =============================[BUILDING]==================================

set +e
irken "$@" "$SOURCE"
BUILD_EXIT_CODE=$?
set -e

if ! contains $BUILD_EXIT_CODE ${IGNORE_BUILD_EXIT_CODES[@]} ; then
    >&2 echo "Build exited with $BUILD_EXIT_CODE"
    exit $BUILD_EXIT_CODE
fi

echo =============================[RUNNING]==================================

if [ ! -r "$BIN" ] ; then
    >&2 echo "Binary file '$BIN' missing."
    exit 1
fi

"$BIN"
