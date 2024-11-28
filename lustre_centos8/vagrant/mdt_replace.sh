#!/bin/bash

zpool status mdt0 |grep 3600 | awk '{print $1}' > mdt0_disks.txt
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
	echo "----------------"
	first=`multipath -ll |grep -A 5 $temp |grep sd | awk '{print $3}'  |grep sd` 
	second=`multipath -ll |grep -A 5 $temp |grep sd | awk '{print $4}'  |grep sd`
#	zpool offline mdt0 /dev/mapper/$line
#	multipath -f /dev/mapper/$temp
#	wipefs -a /dev/${first}
#	partprobe /dev/${first}
#	partprobe /dev/${second}
#	systemctl restart multipathd
#	sleep 3
#	zpool replace mdt0 /dev/mapper/$line /dev/mapper/$temp
#	partner_first=`ssh mds1 multipath -ll |grep -A 5 $temp |grep sd | awk '{print $3}'  |grep sd`
#	partner_second=`ssh mds1 multipath -ll |grep -A 5 $temp |grep sd | awk '{print $4}'  |grep sd`
#	ssh mds1 multipath -f /dev/mapper/$temp
#	ssh mds1 systemctl restart multipathd
#	sleep 3
#	ssh mds1 partprobe /dev/${partner_first}
#	sleep 3
#	ssh mds1 partprobe /dev/${partner_second}
#	sleep 3
#	echo $first $second $partner_first $partner_second
	sleep 10
done < mdt0_disks.txt
