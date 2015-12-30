fdisk -l /dev/sda

if [[ -z `fdisk -l /dev/sda|grep sda2|grep Extended` ]]
then

if [[ -z `fdisk -l /dev/sda|tail -1|grep cylinder` && ( `fdisk -l /dev/sda|grep '/dev/sda1'|awk '{print $3}'` -eq 1 || `fdisk -l /dev/sda|grep '/dev/sda1'|awk '{print $3}'` -eq 2048 ) ]]
then 
fdisk /dev/sda <<EOF!
d
2
n
p
2


w
q
EOF!

else
fdisk /dev/sda <<EOF!
d
2
n
p
3


n
p
2


d
3

w
q
EOF!
fi

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
reboot
