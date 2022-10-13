# RouterOS-iplists.firehol.org
Files to update RouterOS lists to block offenders from iplists.firehol.org

Intentions:
The intention is to block incoming and outgoing connections to attacking IPs and Botnet networks (hence also blocking out).
Lists are updated every 2 hours.
Scripts on routerOS are at the default value of updating every 6 hours.

Important:
My script use the internet interface pppoe-out1. If you use other method for connection this rules will not work.
If you want generate your proper rules, use the GenerateListsToRouterOS.bash on your server and generate your lists.

About the files:
The files with .script on extension is to copy and paste on RouterOS Terminal.
This will delete the firewall rules (i delete just what the script created) and
replace with update IP Blocks. 

Resources:
Not everyone could use this. 
My RouterOS (7.5-Stable) is on a PCEngines APU2C4 (4GB RAM). 
Level1 and Level2 is almost 400 MB Ram. 
Some devices will make then fail. 

You can contact me on e-mail or twitter (@josiaslg). Feel free to update the scripts to a better version (maybe a better default firewall configuration) and commit to here.
