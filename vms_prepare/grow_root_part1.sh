echo "++++ STAR ++++"
fdisk -l /dev/sda

START_SEC=`fdisk -lc /dev/sda|awk '{if($1 == "/dev/sda2"){print $2}}'`

if [[ -z `fdisk -l /dev/sda|grep sda2|grep Extended` ]]
then

#if [[  `fdisk -l /dev/sda|grep '/dev/sda1'|awk '{print $3}'` -eq 1 || `fdisk -l /dev/sda|grep '/dev/sda1'|awk '{print $3}'` -eq 2048 ]]
#then 
fdisk /dev/sda <<EOF!
d
2
n
p
2
${START_SEC}

w
q
EOF!


#fi

else

fdisk /dev/sda <<EOF!
d
5
d
2
n
e
2


n
l


w
q
EOF!

fi

echo "---- FINISH -----"
fdisk -l /dev/sda


reboot
