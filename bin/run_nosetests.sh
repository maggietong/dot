#!/usr/bin/env bash

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
            --cover-inclusive \
            --cover-package=qali \
            --cover-html-dir=/tmp/cover \
            \
            $TESTS

###  hmmm? -->          --ignore-errors \
# --ignore-errors ignores coverage errors. NoSource, etc.
