#!/bin/sh

export AMBARI_ROOT=/Users/ncole/src/hwx/ambari
export KEYSTORE_ROOT=/Users/ncole/etc/ambari/keystore

echo 'Dropping old...'
#sudo -u postgresql psql -f $AMBARI_ROOT/ambari-server/src/main/resources/Ambari-DDL-Postgres-EMBEDDED-DROP.sql \
#  -v dbname="ambari"
/Library/PostgreSQL/9.3/bin/psql --username postgres --no-password -f $AMBARI_ROOT/ambari-server/src/main/resources/Ambari-DDL-Postgres-EMBEDDED-DROP.sql \
  -v dbname="ambari"

echo 'Creating new...'
#sudo -u postgresql psql -f $AMBARI_ROOT/ambari-server/src/main/resources/Ambari-DDL-Postgres-EMBEDDED-CREATE.sql \
/Library/PostgreSQL/9.3/bin/psql --username postgres --no-password -f $AMBARI_ROOT/ambari-server/src/main/resources/Ambari-DDL-Postgres-EMBEDDED-CREATE.sql \
  -v username="\"ambari\"" \
  -v password="'bigdata'" \
  -v dbname='ambari'

export PGPASSWORD=bigdata
/Library/PostgreSQL/9.3/bin/psql --username ambari -f $AMBARI_ROOT/ambari-server/src/main/resources/Ambari-DDL-Postgres-CREATE.sql \
  -v username="\"ambari\"" \
  -v password="'bigdata'" \
  -v dbname='ambari'

echo 'Resetting certs...'
# ambari_reset_certs.sh
rm -rf $KEYSTORE_ROOT
mkdir -p $KEYSTORE_ROOT
cp -R $AMBARI_ROOT/ambari-server/src/main/resources/db $KEYSTORE_ROOT
cp $AMBARI_ROOT/ambari-server/conf/unix/ca.config $KEYSTORE_ROOT
sed -i bak s,/var/lib/ambari-server/keys/db,/Users/ncole/etc/ambari/keystore/db,g $KEYSTORE_ROOT/ca.config

# for 3.0
rm -rf /private/ambari-server/resources/mpacks-v2/HDPCORE
rm -rf /private/ambari-server/resources/stacks/HDPCORE
rm -rf /private/ambari-server/resources/mpacks-v2/staging
rm -rf /private/ambari-server/resources/mpacks-v2/hdpcore-*
rm -rf /private/ambari-server/resources/mpacks-v2/ODS
rm -rf /private/ambari-server/resources/stacks/ODS

