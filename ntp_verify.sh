#! /bin/bash

if [ "$(ps aux | grep "ntpd" | grep -v "grep" | sed -e 's/\s\+/ /g' | cut -d' ' -f 2)" == "" ] ; then
echo NOTICE: ntp is not running 
service ntp restart
elif [ $(ntpq -pn 2> /dev/null | grep -c "=======") -eq 0 ] ; then
echo NOTICE: ntp is not running
service ntp restart
fi
diff -u /etc/ntp.conf.bak /etc/ntp.conf 1>/dev/null 
if [[ $? != "0" ]] ; then
echo NOTICE: /etc/ntp.conf was changed. Calculated diff:
diff -u /etc/ntp.conf.bak /etc/ntp.conf > /tmp/diff.out ; cat /tmp/diff.out
cp /etc/ntp.conf.bak /etc/ntp.conf
service ntp restart
fi
