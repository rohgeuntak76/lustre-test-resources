#!/bin/bash

host=`hostname`
volume="ost0"
partner="oss2"

function check_status {
	if [ $1 -ne 0 ]
	then
		exit
	fi
	sleep 3
}
function wait_resilvering {
        while [ 1 ]
        do
		val=`zpool status $volume | grep "(resilvering)" |wc -l`; check_status $?
                if [ $val -eq 0 ]
                then
                        echo "resilvering finished"
                        break
                else
                        echo "resilvering..."
                        sleep 30
                fi
        done
}

while read line
do
	target=`echo $line | awk '{print $1}'`
	first=`echo $line | awk '{print $2}'`
	second=`echo $line | awk '{print $3}'`
	
	check_parted=`fdisk -l /dev/mapper/${target}  |grep "Disk label type" |wc -l`
	if [ $check_parted -eq 1 ] 
	then
		zpool offline $volume /dev/mapper/$target; check_status $?
		multipath -f /dev/mapper/$target; check_status $?
	
		wipefs -a /dev/${first}; check_status $?
	
		partprobe /dev/${first}; check_status $?
	
		partprobe /dev/${second}; check_status $?
	
		systemctl restart multipathd; check_status $?
	
		partner_first=`ssh -f ${partner} multipath -ll |grep -A 5 $target |grep sd | awk '{print $3}'  |grep sd`
		partner_second=`ssh -f ${partner} multipath -ll |grep -A 5 $target |grep sd | awk '{print $4}'  |grep sd`
		ssh -f ${partner} multipath -f /dev/mapper/$target; check_status $?
	
		ssh -f ${partner} systemctl restart multipathd; check_status $?
	
		ssh -f ${partner} partprobe /dev/${partner_first}; check_status $?
	
		ssh -f ${partner} partprobe /dev/${partner_second} ; check_status $?
		zpool replace ${volume} /dev/mapper/$target /dev/mapper/$target; check_status $?
		wait_resilvering; check_status $? #sleep 200
	fi
	sleep 5
done < ${host}_${volume}_replace_target.txt
