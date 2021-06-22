firewall-cmd --zone=public --list-ports 
firewall-cmd --zone=public --add-port=8559/tcp --permanent


systemctl reload firewalld
