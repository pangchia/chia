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

# service

```
systemctl disable apt-daily.service
systemctl disable apt-daily-upgrade.service

```
