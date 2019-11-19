#!/bin/bash
d=2019-01-01
date_today=$(date '+%Y-%m-%d' -d "-10 days")
while [ "$d" != $date_today ]; do 
  echo $d
  	# delete older files per day
	ls -t backup_abo4_$d* | tail -n +2 | xargs rm --
	# newest file per day
	ls -t backup_abo4_$d* | head -n +1 | xargs mv {} archivo/
	echo backup_abo4_$d*
  d=$(date -I -d "$d + 1 day")
done