apt-get install nvme-cli


nvme list


nvme smart-log /dev/nvme0n1
nvme smart-log /dev/nvme0n1 | grep "^temperature"

nvme wdc help
