if [[ -z `fdisk -l /dev/sda|grep sda2|grep Extended` ]]
then

if [[ -z `fdisk -l /dev/sda|tail -1|grep cylinder` ]]
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
