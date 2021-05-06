# chia
give you chia something 




- 356.5 GB of temporary space
- 108.8 GB of final plot file will take 



# new


| K-value	| DRAM (MiB)| Temp Space (GiB) | Temp Space (GB)|
| :------: | :------: | :------: | :------: |
| 32 | 3389 | 239 | 256.6 |
| 33 | 7400  | 512 | 550 |
| 34 | 14800 | 1041 | 1118 |
| 35 | 29600 | 2175 | 2335 |


### PLOT

```

You really never need to plot a plot with a k size larger than 32

A k32 plot can be done by one expert we know in just under 4 hours 
but most experts are creating plots in 5 hours 
and most folks average around 9-12 hours.

```

### LOGIC
```
The first phase generates all of your proofs of space by creating [  seven  ] tables of cryptographic hashes 
and saving them to your temporary directory

Getting going
phase 1 generates all of your proofs of space by creating seven tables of cryptographic hashes
  and saving them to your temporary directory. 
phase 2 back-propagates through the hashes,
phase 3 sorts and algorithmically compress these hashes in the temporary directory while starting to build the final file 
phase 4 completes the file and moves it into your final plot file.



P盘分为四个阶段
阶段1: 正向传播，创建七个哈希加密表，填充空间证明数据，占用大量CPU线程和内存以及SSD读写，CPU多线程只在这个阶段有用；
阶段2: 反向传播，删除无效哈希数据；
阶段3: 对哈希数据压缩整理排序方便检索；
阶段4: 检查数据点，写入最终文件；

注意：
第一阶段 占用大量SSD读写
第四阶段 占用大量HDD读写
建议P盘任务时间间隔960秒也就是16分钟！

```

### SSD
```
NVMe is faster than SAS and SAS is faster than SATA

```
![Compare](http://www.lubaoqiang.com/img/chia_20210430162131.jpg)



### RAM
```
The bitfield back sort is theoretically faster than not using the bitfield 
and we already know that it saves 12% of total writes but requires more RAM

You almost never want to use any bucket values other than 128.



Using anything over the maximum is wasting RAM as you will not plot any faster

```


### THREAD
```
As far as number of threads are concerned you are generally going to want 2 to 4. 
More than 4 seems to have diminishing returns and 2 threads is a lot better than 1. 
More threads also require a bit more memory to successfully complete a plot. 
The threading is only used in phase 1 currently.

```


### THE DIFF OS
```
It is worth noting that Windows suffers 5-10% slower plot times versus MacOS or Linux for now   

```


### MEMORY AND THREAD COUNT
```
As you start parallel plotting you need to be careful to not over allocate memory when you are plotting. 
If you cause your operating system to swap, you are not going to be happy with your outcome. 
You don’t have to be as careful with thread count.
```

### Wallet not synced
```
Why is my wallet not synced? Why can I not connect to wallet from the GUI?
In these cases, your wallet database might be corrupt. Try the following steps:

Shut down chia and all chia proceses, check the task manager to see if they are all shut down. Note that this will cancel running plots, so be careful.
Restart your computer
Delete the ~/.chia/mainnet/wallet/db folder
Restart chia
```

### Support OS

```
MacOS 10.14 Mojave
Windows 10
Ubuntu 18.04 (20.04 highly recommended)
Raspberry Pi OS 64 or Ubuntu 20.04 for Pi/ARM64 (Not recommended for plotting or timelord)
```



### change log level
```
~\.chia\mainnet\config

config\config.yaml to INFO from WARNING and restart

```



###
```
Disable uPnP when running multiple nodes
If you attempt to run more than one node on your local network, 
having uPnP on on both will cause both nodes significant confusion. 
You will need to use powershell to disable uPnP on all but one.

cd %systemdrive%%homepath%\AppData\Local\Chia-Blockchain\app-1.1.2\resources\app.asar.unpacked\daemon\
    ./chia.exe configure --enable-upnp false


```



###  If you have 10TB

```
If you have 10TB and there are 200PB of total storage on mainnet then you would expect to win ~0.46 TXCH per day on average. The math is .010 PB/200 PB * 4608 * 2 = 0.46. That means that over a long enough period of time you will expect to average out to generally winning every 4-5 days.
```


# NVME SSD     more full , more perform poor

```
Consumer NVMe SSDs also generally have low amount of spare area or overprovisioning, and perform poorly when they get close to being full. 
```

#
```
 U.2 is the most common enterprise SSD form factor, but M.2 110mm was also very popular in a few hyperscale cloud providers like Facebook and Microsoft. I recommend data center U.2 NVMe SSDs for plotting, but there are plenty of good options in M.2 110mm and AIC as well
```
