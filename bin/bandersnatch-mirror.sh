#!/bin/sh

unset PYTHONPATH
unset PYTHONUSERBASE
unset PYTHONSTARTUP

source ~/virtualenv/bandersnatch/bin/activate

nohup bandersnatch -c $VIRTUAL_ENV/etc/bandersnatch.conf mirror > /dev/null 2>&1 &

##### Config looks like ...
# [mirror]
# directory = /Users/miburr/pypi
# master = https://pypi.python.org
# timeout = 10
# workers = 3
# stop-on-error = false
# delete-packages = true
# [statistics]
