#!/bin/sh

pushd ~/src/hwx/ambari/ambari-admin
mvn clean compile package -DskipTests
#rm -f ~/etc/ambari/resources/views/ambari-admin*
cp target/ambari-admin*.jar ~/etc/ambari/resources/views
rm -rf ~/etc/ambari/resources/views/work
popd
