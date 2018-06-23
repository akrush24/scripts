#!/bin/bash
cd /home/akrush/CloudMail
nohup sudo mono wdmrc.exe -p 801 &
sleep 10
sudo mount --rw -t davfs http://127.0.0.1:801 /mnt/cloud.mail.davfs/
