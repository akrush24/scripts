#!/bin/bash
df -h|grep '/mnt/cloud.mail.davfs'&&ps -ef|grep 'rsync --progress -avh /mnt/cloud.mail.davf[s]/'||rsync --progress -avh /mnt/cloud.mail.davfs/Camera\ Uploads* /media/CloudMail.Ru/
