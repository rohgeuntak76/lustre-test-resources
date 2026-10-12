#!/bin/bash

host=`hostname`
volume="ost1"
outfile="${host}_${volume}_replace_target.txt"
parted="${host}_${volume}_parted_disk.txt"

zdb -l -A $volume |grep part | cut -d "-" -f 5 |cut -d "'" -f 1 > ${parted}

if [ -e ${outfile} ]
then
                rm -f ${outfile}
fi

while read line
do
	if [ `echo $line | wc -L` -eq 33 ]
	then
		temp=$line
	elif [ `echo $line | wc -L` -eq 34 ]
	then
		temp=`echo $line | cut -c1-33`
	fi
	first=`multipath -ll |grep -A 5 $temp |grep sd | awk '{print $3}'  |grep sd` 
	second=`multipath -ll |grep -A 5 $temp |grep sd | awk '{print $4}'  |grep sd`

	echo $temp $first $second >> ${outfile}

done < ${parted}
