#!/bin/bash
nohup rdesktop -u akrushelnitskiy@at-consulting.ru -g 1590x850 -r disk:r=/home/akrush/ $2 $3 $4 $5 $6 -T $1 $1 > /dev/null 2>&1 &
