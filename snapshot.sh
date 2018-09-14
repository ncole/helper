#!/bin/sh

cmd=$1
snap=$2

db_cmd=""
hosts=${@:3}

case "$1" in
  "take")
    cmd="save"
    ;;
  "go")
    cmd="restore"
    ;;
  "list")
    hosts=${@:2}
    snap=""
    ;;
  "take-db")
    cmd="save"
    db_cmd="take"
    ;;
  "go-db")
    cmd="restore"
    db_cmd="go"
    ;;
  "delete-db")
    cmd="delete"
    db_cmd="delete"
    ;;
esac

for s in $hosts; do
  echo "$s..."
  if [ "$cmd" == "list" ]
  then
    vm_name=`VBoxManage list vms | grep -o '".*"' | sed 's/"//g' | grep $s`
    VBoxManage snapshot $vm_name list
  else
    vagrant snapshot ${cmd} $s ${snap}
  fi
done

if [ "x$db_cmd" != "x" ] ; then
  snapshot_db.sh $db_cmd $snap
fi

case "$1" in
  "delete-db")
    hosts=${@:2}
    # clear && snapshot.sh list $hosts[1]
    ;;
esac
