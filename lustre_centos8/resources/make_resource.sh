#!/bin/bash

#pcs resource create MGS ocf:lustre:Lustre target=/dev/mapper/mpatha mountpoint=/mnt/MGS
#pcs resource create test-MDT0000 ocf:lustre:Lustre target=/dev/mapper/mpathb mountpoint=/mnt/MDT0
pcs resource create test-MDT0001 ocf:lustre:Lustre target=/dev/mapper/mpathc mountpoint=/mnt/MDT1
pcs resource create test-OST0000 ocf:lustre:Lustre target=/dev/mapper/mpathd mountpoint=/mnt/OST0
pcs resource create test-OST0001 ocf:lustre:Lustre target=/dev/mapper/mpathe mountpoint=/mnt/OST1
pcs resource create test-OST0002 ocf:lustre:Lustre target=/dev/mapper/mpathf mountpoint=/mnt/OST2
pcs resource create test-OST0003 ocf:lustre:Lustre target=/dev/mapper/mpathg mountpoint=/mnt/OST3
