

service --status-all

手动启动
service network-manager start
service NetworkManager start
systemctl start NetworkManager.service

查询开机自动启动
systemctl is-enabled NetworkManager.service

设置开机自动启动
systemctl enable NetworkManager.service


https://websiteforstudents.com/how-to-list-services-on-ubuntu-20-04-18-04/
