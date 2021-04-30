# chia
give you chia something 




- 356.5 GB of temporary space
- 108.8 GB of final plot file will take 



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

```

### SSD
```
NVMe is faster than SAS and SAS is faster than SATA

```

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
