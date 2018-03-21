#!/bin/sh

PRG="$0"
PRGDIR=`dirname "$PRG"`
EXECUTABLE=appctl.sh

if [ ! -x "$PRGDIR"/"$EXECUTABLE" ]; then
    echo "Cannot find $PRGDIR/$EXECUTABLE"
    echo "The file is absent or does not have execute permission"
    echo "This file is needed to run this program"
    exit 1
fi

source "$PRGDIR"/"$EXECUTABLE"
debug

#nohup java  -jar -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=6283  $JAR_FILE > $APP_LOGS_DIR/server.log 2>&1 &















