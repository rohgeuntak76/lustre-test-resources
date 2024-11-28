#!/bin/bash

#zpool status ost0 |grep 3600 | awk '{print $1}' > ost0_disks.txt
while read line
do
	if [ `echo $line | wc -L` -eq 33 ]
	then
		temp=$line
	elif [ `echo $line | wc -L` -eq 34 ]
	then
		temp=`echo $line | cut -c1-33`
	fi
	echo $temp
	first=`multipath -ll |grep -A 5 $temp |grep sd | awk '{print $3}'  |grep sd` 
	second=`multipath -ll |grep -A 5 $temp |grep sd | awk '{print $4}'  |grep sd`
	zpool offline ost0 /dev/mapper/$line
	multipath -f /dev/mapper/$temp
	wipefs -a /dev/${first}
	partprobe /dev/${first}
	partprobe /dev/${second}
	systemctl restart multipathd
	sleep 3
	zpool replace ost0 /dev/mapper/$line /dev/mapper/$temp
	partner_first=`ssh oss2 multipath -ll |grep -A 5 $temp |grep sd | awk '{print $3}'  |grep sd`
	partner_second=`ssh oss2 multipath -ll |grep -A 5 $temp |grep sd | awk '{print $4}'  |grep sd`
	ssh oss2 multipath -f /dev/mapper/$temp
	ssh oss2 systemctl restart multipathd
	sleep 3
	ssh oss2 partprobe /dev/${partner_first}
	ssh oss2 partprobe /dev/${partner_second}
	echo $first $second $partner_first $partner_second
	sleep 60
done < ost0_disks.txt
	
