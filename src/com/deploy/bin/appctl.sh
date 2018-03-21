#!/bin/sh

# -----------------------------------------------------------------------------
# Control Script for the CATALINA Server
#
# Environment Variable Prerequisites
#
#   Do not set the variables in this script. Instead put them into a script
#   setenv.sh in bin to keep your customizations separate.
#
#   directory structure
#   --- $app.tar.gz(root)
#   --- $app(root)
#       --- bin
#           --- start.sh
#           --- stop.sh
#           --- preload.sh
#           --- online.sh
#           --- offline.sh
#           --- setenv.sh
#       --- logs
#           --- $app.pid
#       --- $app-xxx.jar
#

APP_NAME=beauty-store
APP_PORT=7001


ROOT_PATH=`dirname "$0"`
cd $ROOT_PATH
BIN_PATH=`pwd`
cd ${BIN_PATH}/..
APP_BASE=`pwd`
APP_TMP_DIR=$APP_BASE/tmp
PID_FILE=$APP_TMP_DIR/$APP_NAME.pid
APP_LOGS_DIR=/data/logs/$APP_NAME
JAR_FILE=`ls $APP_BASE/*.jar`


mkdir -p $APP_TMP_DIR

if [ -r "$APP_BASE/bin/setenv.sh" ]; then
    . "$APP_BASE/bin/setenv.sh"
fi


grepAppPID(){
	ps -ef | grep "$JAR_FILE" | grep -v grep | awk '{print $2}'
	#ps -ef | grep "ls *.jar" | grep -v grep | awk '{print $2}'
}

checkApp(){
    result=`grepAppPID`
    echo "checkApp pid result: $result"
    if [[ $result > 0 ]]
    then
        echo "success!"
    else
        echo "fail!"
    fi
}



start(){
    PID=`grepAppPID`
    if [ $PID > 0 ]
    then
        echo "$APP_NAME has already started, it's pid is $PID"
    else
        nohup java $CATALINA_OPTS $JAVA_OPTS  -jar $JAR_FILE > $APP_LOGS_DIR/$APP_NAME.log 2>&1 &
        PID=$!
        echo "$PID" > $PID_FILE
        sleep 5
        checkApp
    fi
}
debug(){
    PID=`grepAppPID`
    if [ $PID > 0 ]
    then
        echo "$APP_NAME has already started, it's pid is $PID"
    else
        nohup java $CATALINA_OPTS  $JAVA_OPTS -jar -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=6283  $JAR_FILE > $APP_LOGS_DIR/server.log 2>&1 &
        PID=$!
        echo "start pid $PID" > $PID_FILE
        echo "$PID" > $PID_FILE
        sleep 5
        checkApp
    fi
}


stop(){
    if [ -f $PID_FILE ] ; then
        PID=`cat $PID_FILE`
        if [ "$PID" == "" ] ; then
            echo "can not find process pid. exists"
            rm $PID_FILE
            exit
        fi

        echo -e "`hostname`: stopping $APP_NAME $PID ... "
        i=0
        max_retry=10
        while [ 1 ]
        do
            if [ ! -d /proc/$PID  ];then
                echo -e "`hostname`: $APP_NAME $PID Stop Success."
                rm $PID_FILE
                exit 0
            else
                kill $PID
            fi
            sleep 6s
            i=`expr $i + 1`
            if [ $i -ge $max_retry ];then
                #退出并返回错误
                echo -e "`hostname`: $APP_NAME $PID Stop Failed."
                exit 1
            fi
        done
    else
        echo "pid file not exists, use pkill"
        pkill -f $JAR_FILE
        if [ $? -eq 0 ]; then
            echo "`hostname`: $APP_NAME $PID Stop success"
        fi
    fi
}
