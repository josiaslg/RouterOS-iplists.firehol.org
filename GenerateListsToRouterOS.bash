#!/usr/local/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin

# The objective is download lists from iplists.firehol.org and
# prepare to be used on RouterOS for basic protection.
# A script on RouterOS will refresh every day, downloading this modified file.
# Execute this script on FreeBSD/BSD* servers. For Linux just change the top to /bin/bash.
# Consult the levels on firehol site.


# Version: 12 octuber 2022v1
# Created by josiaslg@bsd.com.br


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
    echo "/ip firewall filter add chain=input src-address=${line} action=drop" >> $FOLDER_TEMP/$NETWORKS_TO_BLOCK_ROUTEROS_1
    echo "/ip firewall filter add chain=output src-address=${line} action=drop" >> $FOLDER_TEMP/$NETWORKS_TO_BLOCK_ROUTEROS_1
done < "$FOLDER_TEMP/$NETWORKS_TO_BLOCK_1"

# List 2 processing
file="$FOLDER_TEMP/$NETWORKS_TO_BLOCK_2"
while read -r line; do
    [[ "$line" =~ ^#.*$ ]] && continue
    echo "/ip firewall filter add chain=input src-address=${line} action=drop" >> $FOLDER_TEMP/$NETWORKS_TO_BLOCK_ROUTEROS_2
    echo "/ip firewall filter add chain=output src-address=${line} action=drop" >> $FOLDER_TEMP/$NETWORKS_TO_BLOCK_ROUTEROS_2
done < "$FOLDER_TEMP/$NETWORKS_TO_BLOCK_2"

# List 3 processing
file="$FOLDER_TEMP/$NETWORKS_TO_BLOCK_3"
while read -r line; do
    [[ "$line" =~ ^#.*$ ]] && continue
    echo "/ip firewall filter add chain=input src-address=${line} action=drop" >> $FOLDER_TEMP/$NETWORKS_TO_BLOCK_ROUTEROS_3
    echo "/ip firewall filter add chain=output src-address=${line} action=drop" >> $FOLDER_TEMP/$NETWORKS_TO_BLOCK_ROUTEROS_3
done < "$FOLDER_TEMP/$NETWORKS_TO_BLOCK_3"

# List 4 processing
file="$FOLDER_TEMP/$NETWORKS_TO_BLOCK_4"
while read -r line; do
    [[ "$line" =~ ^#.*$ ]] && continue
    echo "/ip firewall filter add chain=input src-address=${line} action=drop" >> $FOLDER_TEMP/$NETWORKS_TO_BLOCK_ROUTEROS_4
    echo "/ip firewall filter add chain=output src-address=${line} action=drop" >> $FOLDER_TEMP/$NETWORKS_TO_BLOCK_ROUTEROS_4
done < "$FOLDER_TEMP/$NETWORKS_TO_BLOCK_4"

# Removing original file
rm $FOLDER_TEMP/$NETWORKS_TO_BLOCK_1
rm $FOLDER_TEMP/$NETWORKS_TO_BLOCK_2
rm $FOLDER_TEMP/$NETWORKS_TO_BLOCK_3
rm $FOLDER_TEMP/$NETWORKS_TO_BLOCK_4
