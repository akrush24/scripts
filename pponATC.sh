#!/bin/bash
/sbin/ifconfig ppp0 &>/dev/null || sudo /usr/bin/pon ATC
