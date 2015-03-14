#!/usr/bin/env bash

## Usage:
#
# $ cd /where/this/script/lives
# $ ln -s g_util.sh find
# $ ln -s g_util.sh readlink
# ... etc
#

NAME=`basename "$0"`
g"${NAME}" "$@"
