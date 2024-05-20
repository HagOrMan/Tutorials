# Preface
This is by no means a comprehensive list of terminal commands. These are just a couple of commands I've used when working with ML on co-op, related to checking stuff like file sizes, GPU usage, etc.

# Commands
**To see your current CPU usage**, run
```
htop
```

**To see your current GPU usage**, run
```
watch -n0.1 nvidia-smi
```
The `-n` specifies the intervals that you want it to refresh in seconds.

To see your disk space usage and refresh it once every 10 seconds, you can also do something like 
```
watch -n 10 df -h
```
However, in most cases you probably don't need to look at your storage more than once, so that leads us to the next command.

**To check information about space in your filesystem**, use
```
df -h
```
The -h makes it "human-readable". I have used this when downloading huggingface models while working in Microsoft Azure ML Studio. I ran out of cache and wanted to check where the ML models were being saved, so I navigated to `~/.cache/something` and ran the command to find where the models were and why my cache kept running out. 

As a fun segway from that, I then wanted to save the models to my mount folder so they wouldn't take up cache space. However, this meant I needed to add permissions to that folder in order to choose it as a download location. 

**To give permissions to `/mnt`**, or I guess any other folder, run
```
sudo chmod -R 777 /mnt
```

**To see the file size of everything in your current directory**, run
```
du -h --max_depth=1 .
```
