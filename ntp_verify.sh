#! /bin/bash

status=$(service --status-all | grep ntp)

if [[ $status != *"+"* ]] ; then
echo NOTICE: ntp is not running 
service ntp start
fi
diff -u /etc/ntp.conf.bak /etc/ntp.conf 1>/dev/null 
if [[ $? != "0" ]] ; then
echo NOTICE: /etc/ntp.conf was changed. Calculated diff:
diff -u /etc/ntp.conf.bak /etc/ntp.conf > /tmp/diff.out ; cat /tmp/diff.out
sed -i '/pool*/d' /etc/ntp.conf
echo pool ua.pool.ntp.org >> /etc/ntp.conf
service ntp restart
fi
