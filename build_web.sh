#!/bin/sh

pushd ~/src/hwx/ambari/ambari-web

AMBARI_VERSION=${AMBARI_VERSION:-"\$\{ambariVersion\}"}

rm -rf public && mvn compile -DambariVersion=$AMBARI_VERSION

popd

