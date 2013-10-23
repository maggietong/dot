#!/usr/bin/env bash

export QALI_CLUSTER='bb17.spam48'

if [ $# -eq 0 ] ; then
    TESTS=$(find ~/git/mainline/qali -type d -name '*_tests')
else
    TESTS="$@"
fi

rm -rf /tmp/cover
mkdir /tmp/cover
rm -f /tmp/n.html

cd ~/git/mainline
nosetests \
            \
            --with-id \
            \
            --with-html-output \
            --html-out-file=/tmp/n.html \
            \
            --with-coverage \
            --cover-erase \
            --cover-html \
            --ignore-errors \
            --cover-inclusive \
            --cover-package=qali \
            --cover-html-dir=/tmp/cover \
            \
            $TESTS

# --ignore-errors ignores coverage errors. NoSource, etc.
