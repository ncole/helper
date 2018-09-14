#!/bin/sh

cmd=$1
snap=$2


if [ "$cmd" == "take" ] ; then
  /Library/PostgreSQL/9.3/bin/pg_dump --host localhost \
    --port 5432 \
    --username "postgres" \
    --no-password \
    --format custom \
    --blobs \
    --section pre-data \
    --section data \
    --section post-data \
    --verbose \
    --file "/Users/ncole/etc/ambari/db_backups/${snap}.backup" "ambari"
elif [ "$cmd" == "go" ] ; then
  file=/Users/ncole/etc/ambari/db_backups/${snap}.backup
  if [ -f $file ] ; then
    /Library/PostgreSQL/9.3/bin/dropdb \
      --username "postgres" \
      --no-password \
      "ambari"

    /Library/PostgreSQL/9.3/bin/createdb \
      --username "postgres" \
      --no-password \
      --owner ambari \
      "ambari"

    /Library/PostgreSQL/9.3/bin/pg_restore --host localhost \
      --port 5432 \
      --username "postgres" \
      --dbname "ambari" \
      --no-password  \
      --section pre-data \
      --section data \
      --section post-data \
      --verbose "$file"
  fi
elif [ "$cmd" == "delete" ] ; then
  echo "delete ${snap}.backup"
  rm /Users/ncole/etc/ambari/db_backups/${snap}.backup
fi

