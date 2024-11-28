mkfs.lustre --reformat --mgs --servicenode 101.73.20.21@tcp --servicenode 101.73.20.22@tcp --backfstype=ldiskfs /dev/mapper/mpatha1
mkfs.lustre --reformat --mdt --fsname test --index 0 --mgsnode 101.73.20.21@tcp --mgsnode 101.73.20.22@tcp --servicenode 101.73.20.22@tcp --servicenode 101.73.20.21@tcp /dev/mapper/mpatha2
mkfs.lustre --reformat --mdt --fsname test --index 1 --mgsnode 101.73.20.21@tcp --mgsnode 101.73.20.22@tcp --servicenode 101.73.20.21@tcp --servicenode 101.73.20.22@tcp /dev/mapper/mpathb
mkfs.lustre --reformat --ost --fsname test --index 0 --mgsnode 101.73.20.21@tcp --mgsnode 101.73.20.22@tcp --servicenode 101.73.20.21@tcp --servicenode 101.73.20.22@tcp /dev/mapper/mpathc
mkfs.lustre --reformat --ost --fsname test --index 1 --mgsnode 101.73.20.21@tcp --mgsnode 101.73.20.22@tcp --servicenode 101.73.20.22@tcp --servicenode 101.73.20.21@tcp /dev/mapper/mpathd
mkfs.lustre --reformat --ost --fsname test --index 2 --mgsnode 101.73.20.21@tcp --mgsnode 101.73.20.22@tcp --servicenode 101.73.20.21@tcp --servicenode 101.73.20.22@tcp /dev/mapper/mpathe
mkfs.lustre --reformat --ost --fsname test --index 3 --mgsnode 101.73.20.21@tcp --mgsnode 101.73.20.22@tcp --servicenode 101.73.20.22@tcp --servicenode 101.73.20.21@tcp /dev/mapper/mpathf

mkfs.lustre --reformat --ost --fsname test --index 4 --mgsnode 101.73.20.21@tcp --mgsnode 101.73.20.22@tcp --servicenode 101.73.20.21@tcp --servicenode 101.73.20.22@tcp /dev/mapper/mpathg
mkfs.lustre --reformat --ost --fsname test --index 5 --mgsnode 101.73.20.21@tcp --mgsnode 101.73.20.22@tcp --servicenode 101.73.20.22@tcp --servicenode 101.73.20.21@tcp /dev/mapper/mpathh
mkfs.lustre --reformat --ost --fsname test --index 6 --mgsnode 101.73.20.21@tcp --mgsnode 101.73.20.22@tcp --servicenode 101.73.20.21@tcp --servicenode 101.73.20.22@tcp /dev/mapper/mpathi
mkfs.lustre --reformat --ost --fsname test --index 7 --mgsnode 101.73.20.21@tcp --mgsnode 101.73.20.22@tcp --servicenode 101.73.20.22@tcp --servicenode 101.73.20.21@tcp /dev/mapper/mpathj
