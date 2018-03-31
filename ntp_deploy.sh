#! /bin/bash

timedatectl set-ntp no
apt-get install ntp -y -qq
cp /etc/ntp.conf /etc/ntp.conf_default.bak
sed -i '/pool*/d' /etc/ntp.conf
echo pool ua.pool.ntp.org >> /etc/ntp.conf
service ntp restart
ntpcount=$(crontab -l | grep -c "ntp_verify.sh")
if [ $ntpcount -eq  0 ] ; then
crontab -l | { cat; echo '* * * * * ' $(pwd)/ntp_verify.sh; } | crontab -
fi
cp /etc/ntp.conf /etc/ntp.conf.bak
