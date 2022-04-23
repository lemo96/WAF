
#!/bin/bash
# Title:         Block DDoSer ip address / Connection RATE
# Description:   https://github.com/lemo96/WAF
# Date:          Sat Apr 23 14:14:50 +0430 2022
# Version:       1.0.0


# Variables
# ==========
PORT="443"
Blocklist_TIME="3600"
Server_public_ip="1.2.3.4"
Connection_rate="20" 
# ==========


record=`mktemp`

ipset list | grep "temp_hosts"
ipset_ANW=$?


if [ $ipset_ANW -ne 0 ];then
ipset create temp_hosts hash:ip timeout 0
iptables -I INPUT 1 -m set -j DROP  --match-set temp_hosts src
iptables -I FORWARD 1 -m set -j DROP  --match-set temp_hosts src
service iptables save
sudo /sbin/iptables-save > /etc/sysconfig/iptables
sudo /sbin/iptables-save > /etc/iptables/rules.v4
clear
echo "Created iptables Rules"
fi


while [ true ]; do
clear
echo ""
echo "$(tput setaf 6)"Loop Staring in 5 Sec"$(tput sgr0)"

sleep 5

netstat -ntu | grep :$PORT | grep ESTABLISHED | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | head -n 50  > $record
sed -i -e 's/[ \t]*//' $record 

input="$record"
while IFS= read -r line
do

##  ignore LocalIP 
if echo $line | grep "127.0.0.1"; then
  continue
fi
##  ignore etc ip.. 
if echo $line | grep "$Server_public_ip"; then
  continue
fi


#   echo "$line"
PART_A=`echo $line  | cut -d " " -f 1`
PART_B=`echo $line  | cut -d " " -f 2`

if [ "$PART_A" -gt "$Connection_rate" ]; then

echo "$(tput setaf 1)"$PART_B botnet detect have $PART_A"$(tput sgr0)"
# echo "$PART_B botnet detect have $PART_A // `date`" >>logs 
echo "$(tput setaf 2)"$PART_A Blocked $Blocklist_TIME Sec"$(tput sgr0)"
ipset add temp_hosts $PART_B timeout $Blocklist_TIME

fi

done < "$input"

#remove Temp File
rm $record

done
