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
    PROJECT_DIRS=(~/src/hwx/pdr/zookeeper-pdr ~/src/hwx/pdr/hadoop-pdr)
    ;;
  ODS)
    SRC_DIR=~/src/hwx/pdr/ods-pdr
    PROJECT_DIRS=(~/src/hwx/pdr/hbase-pdr)
    ;;
  *)
    ;;
esac

MPACK_BASE=~/src/hwx/ambari/ambari-server/src/main/resources/stacks/$MPACK_NAME/$MPACK_VERSION

# first munge the mpack
#mpack_file=$MPACK_BASE/mpack.json
#mpack_original=$mpack_file.original

#if [ ! -f $mpack_original ]; then
#  cp $mpack_file $mpack_original
#fi

SRC_UPGRADE=$SRC_DIR/ambari-definitions/src/main/resources/mpack-definition/upgrades/upgrade.xml


# then munge the upgrade.xml file
if [ -f $MPACK_BASE/upgrades/upgrade.xml ]; then
  echo "Removing $MPACK_BASE/upgrades/upgrade.xml"
  rm $MPACK_BASE/upgrades/upgrade.xml
  echo "Linking $MPACK_BASE/upgrades/upgrade.xml"
  ln $SRC_UPGRADE $MPACK_BASE/upgrades/upgrade.xml
fi

