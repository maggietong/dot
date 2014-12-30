#!/bin/sh

export VIRTUAL_ENV=~/virtualenv/current
export VIRTUAL_ENV_DISABLE_PROMPT=true
export JAVA_HOME=~/java/jre1.8.0_25.jre/Contents/Home
export PATH="$JAVA_HOME/bin:~/virtualenv/current/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

HERE=$(dirname $0)
HERE=$(greadlink -f $HERE)

nohup "$JAVA_HOME/bin/java" -XstartOnFirstThread -jar ~/eclipse/installation/plugins/org.eclipse.equinox.launcher*.jar -vm="$HERE/../.." > /dev/null 2>&1 &
