mkfs.lustre --ost --replace --fsname test --index 0 --mgsnode 101.73.20.21@tcp --mgsnode 101.73.20.22@tcp --servicenode 101.73.20.21@tcp --servicenode 101.73.20.22@tcp /dev/mapper/mpathd
mkfs.lustre --ost --replace --fsname test --index 1 --mgsnode 101.73.20.21@tcp --mgsnode 101.73.20.22@tcp --servicenode 101.73.20.22@tcp --servicenode 101.73.20.21@tcp /dev/mapper/mpathe
mkfs.lustre --ost --replace --fsname test --index 2 --mgsnode 101.73.20.21@tcp --mgsnode 101.73.20.22@tcp --servicenode 101.73.20.21@tcp --servicenode 101.73.20.22@tcp /dev/mapper/mpathf
mkfs.lustre --ost --replace --fsname test --index 3 --mgsnode 101.73.20.21@tcp --mgsnode 101.73.20.22@tcp --servicenode 101.73.20.22@tcp --servicenode 101.73.20.21@tcp /dev/mapper/mpathg
