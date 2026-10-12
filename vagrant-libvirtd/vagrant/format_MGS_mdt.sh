mkfs.lustre --mgs --servicenode 10.73.20.11@tcp --servicenode 10.73.20.12@tcp --backfstype=ldiskfs /dev/mapper/mpatha
mkfs.lustre --mdt --fsname test --index 0 --mgsnode 10.73.20.11@tcp --mgsnode 10.73.20.12@tcp --servicenode 10.73.20.12@tcp --servicenode 10.73.20.11@tcp /dev/mapper/mpathb
