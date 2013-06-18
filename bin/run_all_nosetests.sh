#!/usr/bin/env bash

#    grep -A 5 '^Ran.*test' ......

export QALI_CLUSTER='bb17.spam48'
#export QALI_CLUSTER='bb17.mam48'
#export QALI_CLUSTER='dd3.sf40'
#export QALI_CLUSTER='bb14.mam96'
#export QALI_CLUSTER='bb14.mam48'

echo 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
echo 'You are using cluster '${QALI_CLUSTER}
echo 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

TESTDIRS=$(find ~/git/mainline/qali -type d -name '*_tests')

for DIR in $TESTDIRS ; do
    cd $DIR
    echo '==================vvv==================='
    pwd
    echo '==================^^^==================='
    nosetests
done
