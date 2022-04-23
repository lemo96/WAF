# WAF
A simple and powerful script to block DDoS and botnet attacks [Linux / Directadmin / WHM /cPanel/Plesk/Apache/Nginx]

This script will help you to prevent attacks on your Linux server.
The most common use of this script is for websites that use ports 80 or 443, etc.

Single: In the file

loop_block_ddoser_ip.sh


Before running, change the following values according to your needs.

PORT = "443"

Blocklist_TIME = "3600"

Server_public_ip = "1.2.3.4"

===========================================================================
setup:


mkdir -p ~/ddosMigration
cd ~/ddosMigration
wget https://raw.githubusercontent.com/lemo96/WAF/main/loop_block_ddoser_ip.sh
chmod +x loop_block_ddoser_ip.sh

./loop_block_ddoser_ip.sh
or 
bash loop_block_ddoser_ip.sh

===========================================================================
If you want to run the file in the background, you can use the apple command

screen bash loop_block_ddoser_ip.sh // Install screen tool first
