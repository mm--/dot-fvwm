#!/bin/bash

[ -f ~/.currenttask ] || exit

date1=$(sed -n '2p' ~/.currenttask)
date2=$(date +%s)
diff=$(($date2-$date1))
h=$(( $diff / 3600 ))
m=$(( ( $diff / 60 ) % 60 ))
s=$(( $diff % 60 ))
sed -n '1p' ~/.currenttask
printf "%02d:%02d\n" $h $m
