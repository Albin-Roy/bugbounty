# Reconnaissance

## Subdomain discovery

| Tools       | Speed     | Results  |
| ----------- | --------- | -------- |
| amass       | slow      | accurate |
| subbrute    | very slow | accurate |
| crtsh       | fast      |          |
| assetfinder | very fast |          |
| sublist3r   | fast      |          |
| findomain   | fast      |          |

##### Commands

###### 1. amass

```
amass enum -d sony.com >> /root/bugbounty/targets/sony/amass.txt
```

###### 2. subbrute

```
subbrute.py sony.com >> /root/bugbounty/targets/sony/subbrute.txt
```

###### 3. crtsh

```
crtsh.py -d sony.com >> /root/bugbounty/targets/sony/crtsh.txt
```

###### 4. assetfinder

```
assetfinder --subs-only sony.com >> /root/bugbounty/targets/sony/assetfinder.txt
```

###### 5. sublist3r

```
sublist3r -d sony.com -o /root/bugbounty/targets/sony/sublister.txt
```

###### 6. findomain

```
findomain-linux -t sony.com -u /root/bugbounty/targets/sony/findomain.txt
```



> Installation
> 
> Move all scripts to /opt/scripts directory
> 
> Export path variable permanently by add this command in .zshrc file 
> 
> - export PATH=$PATH:/opt/scripts  
> 
> Run scripts inside /opt/scripts



#### Combine Results

> cat amass.txt assetfinder.txt crtsh.txt findomain.txt subbrute.txt sublister.txt >> SUBDOMAINS.txt



#### Removing Duplicates

```
cat subdomains.txt | sort -u > subdomains-UNIQUE.txt
```



#### Checking Alive

```
cat subdomains-UNIQUE.txt | httprobe -c 100 > ALIVE.txt
```




