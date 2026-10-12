mkfs.lustre --ost --fsname test --index 0 --mgsnode 10.73.20.11@tcp --mgsnode 10.73.20.12@tcp --servicenode 10.73.20.21@tcp --servicenode 10.73.20.22@tcp /dev/mapper/mpatha
mkfs.lustre --ost --fsname test --index 1 --mgsnode 10.73.20.11@tcp --mgsnode 10.73.20.12@tcp --servicenode 10.73.20.22@tcp --servicenode 10.73.20.21@tcp /dev/mapper/mpathb
mkfs.lustre --ost --fsname test --index 2 --mgsnode 10.73.20.11@tcp --mgsnode 10.73.20.12@tcp --servicenode 10.73.20.21@tcp --servicenode 10.73.20.22@tcp /dev/mapper/mpathm
mkfs.lustre --ost --fsname test --index 3 --mgsnode 10.73.20.11@tcp --mgsnode 10.73.20.12@tcp --servicenode 10.73.20.22@tcp --servicenode 10.73.20.21@tcp /dev/mapper/mpathn
