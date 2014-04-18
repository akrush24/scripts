#!/bin/bash
cd /home/akrush/my_external_ip
/usr/bin/curl -s icanhazip.com > home.txt
####
/usr/local/bin/git commit -a -m "`date`"
/usr/local/bin/git push -u origin master
