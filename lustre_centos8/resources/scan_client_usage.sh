#!/bin/bash
set -e
SLEEP=10
stats_clear()
{
	cd $1
	echo clear >clear
}

stats_print()
{
        cd $1
        echo "===================== $1 ============================"
        for i in *; do 
                [ -d $i ] || continue
	                out=`cat ${i}/stats | grep -v "snapshot_time" | grep -v "ping" || true`
                [ -n "$out" ] || continue
	                echo $i $out
        done
       echo "============================================================================================="
       echo
}

for i in /proc/fs/lustre/mdt/test-MDT0001 /proc/fs/lustre/obdfilter/*OST*; do
        dir="${i}/exports"
        [ -d "$dir" ] || continue
        stats_clear "$dir"
done

echo "Waiting ${SLEEP}s after clearing stats"
sleep $SLEEP

for i in /proc/fs/lustre/mdt/test-MDT0001/ /proc/fs/lustre/obdfilter/*OST*; do
        dir="${i}/exports"
        [ -d "$dir" ] || continue
        stats_print "$dir"
done

