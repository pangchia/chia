 
 # 查询内存
 ```
 sudo lshw -C memory
 ```



 # 查询休眠
 
 ```
 systemctl status sleep.target
 ```
 # 禁止休眠
 ```
 sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
 
 ```
