# WAF
A simple and powerful script to block DDoS and botnet attacks [Linux / Directadmin / WHM /cPanel/Plesk/Apache/Nginx]

This script will help you to prevent attacks on your Linux server.
The most common use of this script is for websites that use ports 80 or 443, etc.

# How it worked:
If more than 20 simultaneous connections are made from one IP on port 443, it will block it for 3600 seconds.


Before running, change the following values according to your needs. [edit: loop_block_ddoser_ip.sh]

PORT = "443" // Port You want to protect

Blocklist_TIME = "3600" // BlackList time

Server_public_ip = "1.2.3.4" //Set VM ip address


# Setup steps:
mkdir -p ~/ddosMigration

cd ~/ddosMigration

wget https://raw.githubusercontent.com/lemo96/WAF/main/loop_block_ddoser_ip.sh

chmod +x loop_block_ddoser_ip.sh

./loop_block_ddoser_ip.sh


# If you want to run the Script in the background
yum install -y screen / centos

sudo apt get install screen -y / ubuntu or debian

screen bash loop_block_ddoser_ip.sh 
