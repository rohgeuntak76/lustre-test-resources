pcs resource create MGS ocf:lustre:Lustre target=/dev/mapper/mpatha1 mountpoint=/mnt/MGS
pcs resource create test-MDT0000 ocf:lustre:Lustre target=/dev/mapper/mpatha2 mountpoint=/mnt/MDT0
pcs resource create test-MDT0001 ocf:lustre:Lustre target=/dev/mapper/mpathb mountpoint=/mnt/MDT1
pcs resource create test-OST0000 ocf:lustre:Lustre target=/dev/mapper/mpathc mountpoint=/mnt/OST0
pcs resource create test-OST0001 ocf:lustre:Lustre target=/dev/mapper/mpathd mountpoint=/mnt/OST1
pcs resource create test-OST0002 ocf:lustre:Lustre target=/dev/mapper/mpathe mountpoint=/mnt/OST2
pcs resource create test-OST0003 ocf:lustre:Lustre target=/dev/mapper/mpathf mountpoint=/mnt/OST3
pcs resource create test-OST0004 ocf:lustre:Lustre target=/dev/mapper/mpathg mountpoint=/mnt/OST4
pcs resource create test-OST0005 ocf:lustre:Lustre target=/dev/mapper/mpathh mountpoint=/mnt/OST5
pcs resource create test-OST0006 ocf:lustre:Lustre target=/dev/mapper/mpathi mountpoint=/mnt/OST6
pcs resource create test-OST0007 ocf:lustre:Lustre target=/dev/mapper/mpathj mountpoint=/mnt/OST7

