
# read only

sudo mount -t ntfs-3g  /dev/sdg2 /windis1k -ro force

# read rw

sudo mount -t ntfs-3g /dev/sdg2 /windisk1 -ow force   
