
```
 scp netperf-2.5.0.tar.gz root@10.240.13.2:/home/netperf-2.5.0.tar.gz                      100% 1886KB  25.3MB/s   00:00
```

```
 scp -c aes128-ctr netperf-2.5.0.tar.gz root@10.240.13.2:/tmp/netperf-2.5.0.tar.gz         100% 1886KB  86.6MB/s   00:00
```

```
 scp -c aes192-cbc netperf-2.5.0.tar.gz root@10.240.13.2:/root/netperf-2.5.0.tar.gz        100% 1886KB 109.1MB/s   00:00
```


 ssh -Q cipher

vi /etc/ssh/ssh_config

Ciphers aes128-ctr,aes192-ctr,aes256-ctr,aes128-cbc,3des-cbc,arcfour,arcfour128,arcfour256


sudo systemctl restart ssh

