
# read only

sudo mount -t ntfs-3g  /dev/sdg2 /windis1k -ro force

# read rw

sudo mount -t ntfs-3g /dev/sdo2 /windisk2 -wo force  

sudo ntfsfix /dev/sdk2
