#!/bin/sh


MPACK_NAME=$1
if [[ -z $MPACK_NAME ]]; then
  echo "Mpack name is required, such as HDPCORE, ODS"
  exit 1
fi

MPACK_VERSION=$2

if [[ -z $MPACK_VERSION ]]; then
  echo "Mpack version is required, such as 1.0.0-bN"
  exit 1
fi

case $MPACK_NAME in
  HDPCORE)
    SRC_DIR=~/src/hwx/pdr/hdpcore-pdr
    MODULE_DIRS[0]=~/src/hwx/pdr/hadoop-pdr/ambari-definitions/hadoop_clients
    MODULE_DIRS[1]=~/src/hwx/pdr/hadoop-pdr/ambari-definitions/hdfs
    MODULE_DIRS[2]=~/src/hwx/pdr/hadoop-pdr/ambari-definitions/mapreduce2
    MODULE_DIRS[3]=~/src/hwx/pdr/hadoop-pdr/ambari-definitions/yarn
    MODULE_DIRS[4]=~/src/hwx/pdr/zookeeper-pdr/ambari-definitions/zookeeper
    MODULE_DIRS[5]=~/src/hwx/pdr/zookeeper-pdr/ambari-definitions/zookeeper_clients
    ;;
  ODS)
    SRC_DIR=~/src/hwx/pdr/ods-pdr
    MODULE_DIRS[4]=~/src/hwx/pdr/hbase-pdr/ambari-definitions/hbase
    MODULE_DIRS[5]=~/src/hwx/pdr/hbase-pdr/ambari-definitions/hbase_clients
    ;;
  *)
    ;;
esac

STACK_BASE=~/src/hwx/ambari/ambari-server/src/main/resources/stacks/$MPACK_NAME/$MPACK_VERSION

SRC_UPGRADE=$SRC_DIR/ambari-definitions/src/main/resources/mpack-definition/upgrades/upgrade.xml

# then munge the upgrade.xml file
if [ -f $STACK_BASE/upgrades/upgrade.xml ]; then
  echo "Removing $STACK_BASE/upgrades/upgrade.xml"
  rm $STACK_BASE/upgrades/upgrade.xml

  echo "Linking $STACK_BASE/upgrades/upgrade.xml"
  ln -s $SRC_UPGRADE $STACK_BASE/upgrades/upgrade.xml

  for x in ${MODULE_DIRS[@]}; do
    echo "${x}"
  done


fi

