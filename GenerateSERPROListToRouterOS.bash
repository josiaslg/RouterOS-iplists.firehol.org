#!/usr/local/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin

# The objective is download list from SERPRO and
# prepare to be used on RouterOS for basic protection.
# A script on RouterOS will refresh every day, downloading this modified file.
# Execute this script on FreeBSD/BSD* servers. For Linux just change the top to /bin/bash.
# 

# Version: 13 octuber 2022v1
# Initial to generate rules

# Created by josiaslg@bsd.com.br / @josiaslg

# Interface to Internet
# Change to yours. This is who connect by pppoe. 
# If you use static IP, DHCP or other, edit with the correct interface
IF_INTERNET=pppoe-out1

# Folder Temp
FOLDER_TEMP=/tmp

# Level Serpro
NETWORKS_TO_BLOCK_1=blocklist.txt
NETWORKS_TO_BLOCK_ROUTEROS_1=RouterOS_Serpro_$NETWORKS_TO_BLOCK_1

# Download lists
wget https://s3.i02.estaleiro.serpro.gov.br/blocklist/$NETWORKS_TO_BLOCK_1 -O $FOLDER_TEMP/$NETWORKS_TO_BLOCK_1

# List 1 processing
file="$FOLDER_TEMP/$NETWORKS_TO_BLOCK_1"
while read -r line; do
    [[ "$line" =~ ^#.*$ ]] && continue
    echo "/ip firewall filter add chain=input src-address=${line} in-interface=$IF_INTERNET action=drop  comment "$NETWORKS_TO_BLOCK_ROUTEROS_1"" >> $FOLDER_TEMP/$NETWORKS_TO_BLOCK_ROUTEROS_1
    echo "/ip firewall filter add chain=output dst-address=${line} out-interface=$IF_INTERNET action=drop comment "$NETWORKS_TO_BLOCK_ROUTEROS_1"" >> $FOLDER_TEMP/$NETWORKS_TO_BLOCK_ROUTEROS_1
done < "$FOLDER_TEMP/$NETWORKS_TO_BLOCK_1"

# Removing original file
rm $FOLDER_TEMP/$NETWORKS_TO_BLOCK_1

cd /home/suporte/RouterOS-iplists.firehol.org
mv /tmp/RouterOS_firehol_level* ./
git add -A
git commit -a  -m 'Update lists'
git push
