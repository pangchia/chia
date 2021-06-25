sudo mkdir /mnt/ramdisk

sudo mount -t tmpfs -o rw,size=110G tmpfs /mnt/ramdisk



```

vi /etc/fstab

+   tmpfs  /mnt/ramdisk  tmpfs  rw,size=110G  0   0

```








sudo umount /mnt/ramdisk
