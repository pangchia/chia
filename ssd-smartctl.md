
apt install smartmontools

smartctl -A /dev/nvme0n1



=== START OF SMART DATA SECTION ===
SMART/Health Information (NVMe Log 0x02)
Critical Warning:                   0x00
Temperature:                        42 Celsius
Available Spare:                    100%
Available Spare Threshold:          10%
Percentage Used:                    47%
Data Units Read:                    1,187,574,244 [608 TB]
Data Units Written:                 1,114,810,792 [570 TB]
Host Read Commands:                 2,179,076,336
Host Write Commands:                1,832,312,866
Controller Busy Time:               16,131
Power Cycles:                       31
Power On Hours:                     1,311
Unsafe Shutdowns:                   10
Media and Data Integrity Errors:    0
Error Information Log Entries:      1
Warning  Comp. Temperature Time:    9
Critical Comp. Temperature Time:    0
