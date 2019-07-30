#!/bin/bash
CHKSTR=`ps aux| grep -v grep | grep lockscreen`
if  [[ $CHKSTR == *lockscreen* ]]; then
    kbd=`setxkbmap -print | sed -n 's#xkb_symbols[^"]*"\([^"]*\)".*$#\1#p' | awk -F+ '{print $2}'`
    if [[ $kbd == ru ]]; then
        xdotool key 'alt+shift'
    fi
fi
