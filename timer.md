```
systemctl list-timers -a
```

```
systemctl disable apt-daily.timer 

Removed /etc/systemd/system/timers.target.wants/apt-daily.timer.
```

```
systemctl disable apt-daily-upgrade.timer 

Removed /etc/systemd/system/timers.target.wants/apt-daily-upgrade.timer.
```

```
systemctl disable motd-news.timer 

Removed /etc/systemd/system/timers.target.wants/motd-news.timer.
```


```
systemctl stop motd-news.timer
systemctl stop apt-daily-upgrade.timer 
systemctl stop apt-daily.timer

```

# service

```
systemctl disable apt-daily.service
systemctl disable apt-daily-upgrade.service

```


```
关闭fstrim.timer服务：
hw00001:~ # systemctl stop fstrim.timer



取消fstrim.timer服务开机自启动：
hw00001:~ # systemctl disable fstrim.timer


关闭fstrim.service服务：
hw00001:~ # systemctl stop fstrim.service

取消fstrim.service服务开机自启动：
hw00001:~ # systemctl disable fstrim.service

查看fstrim.timer当前服务状态，确保“Active”（当前服务状态）是“inactive (dead)”。
hw00001:~ # systemctl status fstrim.timer

查看fstrim.service当前服务状态，确保“Active”（当前服务状态）是“inactive (dead)”。
hw00001:~ # systemctl status fstrim.service


查看fstrim.timer开机自启动状态，确保fstrim.timer的Loaded（开机自启动）状态是“disabled”。
hw00001:~ # systemctl list-unit-files | grep fstrim.timer


查看fstrim.service开机自启动状态，确保fstrim.service的Loaded（开机自启动）状态是“static”。
hw00001:~ # systemctl list-unit-files | grep fstrim.service


(venv) root@lubq-x99:/var/log# systemctl disable anacron.service
Synchronizing state of anacron.service with SysV service script with /lib/systemd/systemd-sysv-install.
Executing: /lib/systemd/systemd-sysv-install disable anacron
Removed /etc/systemd/system/multi-user.target.wants/anacron.service.
(venv) root@lubq-x99:/var/log# /lib/systemd/systemd-sysv-install disable anacron



```
