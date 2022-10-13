#!/usr/local/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin

# The objective is download lists from iplists.firehol.org and
# prepare to be used on RouterOS for basic protection.
# A script on RouterOS will refresh every day, downloading this modified file.
# Execute this script on FreeBSD/BSD* servers. For Linux just change the top to /bin/bash.
# Consult the levels on firehol site.


# Version: 12 octuber 2022v2
# Include the internet interface to apply rules
# Version: 12 octuber 2022v1
# Initial to generate rules

# Created by josiaslg@bsd.com.br / @josiaslg

# Interface to Internet
# Change to yours. This is who connect by pppoe. 
# If you use static IP, DHCP or other, edit with the correct interface
IF_INTERNET=pppoe-out1

# Folder Temp
FOLDER_TEMP=/tmp

# Level 1
NETWORKS_TO_BLOCK_1=firehol_level1.netset
NETWORKS_TO_BLOCK_ROUTEROS_1=RouterOS_$NETWORKS_TO_BLOCK_1

# Level 2
NETWORKS_TO_BLOCK_2=firehol_level2.netset
NETWORKS_TO_BLOCK_ROUTEROS_2=RouterOS_$NETWORKS_TO_BLOCK_2

# Level 3
NETWORKS_TO_BLOCK_3=firehol_level3.netset
NETWORKS_TO_BLOCK_ROUTEROS_3=RouterOS_$NETWORKS_TO_BLOCK_3

# Level 4
NETWORKS_TO_BLOCK_4=firehol_level4.netset
NETWORKS_TO_BLOCK_ROUTEROS_4=RouterOS_$NETWORKS_TO_BLOCK_4

# Download lists
wget https://iplists.firehol.org/files/$NETWORKS_TO_BLOCK_1 -O $FOLDER_TEMP/$NETWORKS_TO_BLOCK_1
wget https://iplists.firehol.org/files/$NETWORKS_TO_BLOCK_2 -O $FOLDER_TEMP/$NETWORKS_TO_BLOCK_2
wget https://iplists.firehol.org/files/$NETWORKS_TO_BLOCK_3 -O $FOLDER_TEMP/$NETWORKS_TO_BLOCK_3
wget https://iplists.firehol.org/files/$NETWORKS_TO_BLOCK_4 -O $FOLDER_TEMP/$NETWORKS_TO_BLOCK_4

# List 1 processing
file="$FOLDER_TEMP/$NETWORKS_TO_BLOCK_1"
while read -r line; do
    [[ "$line" =~ ^#.*$ ]] && continue
    echo "/ip firewall filter add chain=input src-address=${line} in-interface=$IF_INTERNET action=drop" >> $FOLDER_TEMP/$NETWORKS_TO_BLOCK_ROUTEROS_1
    echo "/ip firewall filter add chain=output dst-address=${line} out-interface=$IF_INTERNET action=drop" >> $FOLDER_TEMP/$NETWORKS_TO_BLOCK_ROUTEROS_1
done < "$FOLDER_TEMP/$NETWORKS_TO_BLOCK_1"

# List 2 processing
file="$FOLDER_TEMP/$NETWORKS_TO_BLOCK_2"
while read -r line; do
    [[ "$line" =~ ^#.*$ ]] && continue
    echo "/ip firewall filter add chain=input src-address=${line} in-interface=$IF_INTERNET action=drop" >> $FOLDER_TEMP/$NETWORKS_TO_BLOCK_ROUTEROS_2
    echo "/ip firewall filter add chain=output dst-address=${line} out-interface=$IF_INTERNET action=drop" >> $FOLDER_TEMP/$NETWORKS_TO_BLOCK_ROUTEROS_2
done < "$FOLDER_TEMP/$NETWORKS_TO_BLOCK_2"

# List 3 processing
file="$FOLDER_TEMP/$NETWORKS_TO_BLOCK_3"
while read -r line; do
    [[ "$line" =~ ^#.*$ ]] && continue
    echo "/ip firewall filter add chain=input src-address=${line} in-interface=$IF_INTERNET action=drop" >> $FOLDER_TEMP/$NETWORKS_TO_BLOCK_ROUTEROS_3
    echo "/ip firewall filter add chain=output dst-address=${line} out-interface=$IF_INTERNET action=drop" >> $FOLDER_TEMP/$NETWORKS_TO_BLOCK_ROUTEROS_3
done < "$FOLDER_TEMP/$NETWORKS_TO_BLOCK_3"

# List 4 processing
file="$FOLDER_TEMP/$NETWORKS_TO_BLOCK_4"
while read -r line; do
    [[ "$line" =~ ^#.*$ ]] && continue
    echo "/ip firewall filter add chain=input src-address=${line} in-interface=$IF_INTERNET action=drop" >> $FOLDER_TEMP/$NETWORKS_TO_BLOCK_ROUTEROS_4
    echo "/ip firewall filter add chain=output dst-address=${line} out-interface=$IF_INTERNET action=drop" >> $FOLDER_TEMP/$NETWORKS_TO_BLOCK_ROUTEROS_4
done < "$FOLDER_TEMP/$NETWORKS_TO_BLOCK_4"

# Removing original file
rm $FOLDER_TEMP/$NETWORKS_TO_BLOCK_1
rm $FOLDER_TEMP/$NETWORKS_TO_BLOCK_2
rm $FOLDER_TEMP/$NETWORKS_TO_BLOCK_3
rm $FOLDER_TEMP/$NETWORKS_TO_BLOCK_4

cd /home/suporte/RouterOS-iplists.firehol.org
mv /tmp/RouterOS_firehol_level* ./
git commit -a  -m 'Update lists'
git push
