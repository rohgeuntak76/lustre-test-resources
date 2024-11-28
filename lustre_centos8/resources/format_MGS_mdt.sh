mkfs.lustre --mgs --servicenode 101.73.20.21@tcp --servicenode 101.73.20.22@tcp --backfstype=ldiskfs /dev/mapper/mpatha1
mkfs.lustre --mdt --fsname test --index 0 --mgsnode 101.73.20.21@tcp --mgsnode 101.73.20.22@tcp --servicenode 101.73.20.22@tcp --servicenode 101.73.20.21@tcp /dev/mapper/mpatha2
mkfs.lustre --mdt --fsname test --index 1 --mgsnode 101.73.20.21@tcp --mgsnode 101.73.20.22@tcp --servicenode 101.73.20.21@tcp --servicenode 101.73.20.22@tcp /dev/mapper/mpathb
