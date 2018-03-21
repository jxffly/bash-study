#!/bin/sh

APP_NAME=beauty-store
LOG_HOME="/data/logs/$APP_NAME"
TMP_HOME="/data/project/$APP_NAME/tmp"
#MEMORY=`free -m | awk '/Mem/{print $2}'`
MEMORY=`free -m | awk '/^-/{print $4}'`
if [ $MEMORY -gt 15000 ];then
    JVM_HEAP="8192"
elif [ $MEMORY -gt 7500 ];then
    JVM_HEAP="4096"
elif [ $MEMORY -gt 3500 ];then
    JVM_HEAP="1600"
elif [ $MEMORY -gt 2000 ];then
    JVM_HEAP="1024"
else
    JVM_HEAP=$((MEMORY/5*2))
fi
JVM_EDEN=$((JVM_HEAP/2))
JVM_META=$((JVM_HEAP/6))
JVM_MAX_META=$((JVM_HEAP/3))
if ! netstat -tln 2>&1 | grep ':7777' >/dev/null 2>&1; then
    JMX_PORT=7777
else
    JMX_PORT=$((RANDOM%10+7780))
fi
JAVA_VERSION=`java -version 2>&1 |awk 'NR==1{ gsub(/"/,""); print $3 }'`
if [[ "$JAVA_VERSION" > "1.8" ]]; then
    JAVA_OPTS="-Dspring.profiles.active=@environment@ -server -Xms${JVM_HEAP}m -Xmx${JVM_HEAP}m -Xss256k -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:MetaspaceSize=${JVM_META}m -XX:MaxMetaspaceSize=${JVM_MAX_META}m"
else
    JAVA_OPTS="-Dspring.profiles.active=@environment@ -server -Xms${JVM_HEAP}m -Xmx${JVM_HEAP}m -Xmn${JVM_EDEN}m -XX:SurvivorRatio=8 -XX:PermSize=256m -XX:MaxPermSize=256m -Xss256k -XX:-UseAdaptiveSizePolicy -XX:MaxTenuringThreshold=15 -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+UseCMSCompactAtFullCollection -XX:+CMSParallelRemarkEnabled -XX:+CMSPermGenSweepingEnabled -XX:+UseFastAccessorMethods -XX:+CMSClassUnloadingEnabled -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=70"
fi
JAVA_OPTS="${JAVA_OPTS} -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=$LOG_HOME/oom.hprof -XX:ErrorFile=$LOG_HOME/hs_err_pid_%p.log"
JAVA_OPTS="${JAVA_OPTS} -verbose:gc -Xloggc:$LOG_HOME/gc.log -XX:+PrintHeapAtGC -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintTenuringDistribution -XX:+PrintGCApplicationStoppedTime"
JAVA_OPTS="${JAVA_OPTS} -XX:-UseCompressedOops"
JAVA_OPTS="${JAVA_OPTS} -Djava.awt.headless=true -Dfile.encoding=UTF-8"
JAVA_OPTS="${JAVA_OPTS} -Djava.net.preferIPv4Stack=true -Dsun.net.client.defaultConnectTimeout=10000 -Dsun.net.client.defaultReadTimeout=30000"
JAVA_OPTS="${JAVA_OPTS} -Dproject.name=$PROJECT_NAME -Djava.io.tmpdir=$TMP_HOME"
JAVA_OPTS="${JAVA_OPTS} -Djava.util.concurrent.ForkJoinPool.common.parallelism=32"
JAVA_OPTS="${JAVA_OPTS} -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.port=$JMX_PORT -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"

echo "run configure to be set is :"$JAVA_OPTS
export JAVA_OPTS
