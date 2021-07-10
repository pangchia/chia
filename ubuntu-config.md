
### not sleep

```
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

```



### file open limit


```
vi /etc/security/limits.conf


* soft     nproc          65535    
* hard     nproc          65535   
* soft     nofile         65535   
* hard     nofile         65535
root soft     nproc          65535    
root hard     nproc          65535   
root soft     nofile         65535   
root hard     nofile         65535



ulimit -n 65535  


ulimit -Sn
ulimit -Hn  
ulimit -a
```
