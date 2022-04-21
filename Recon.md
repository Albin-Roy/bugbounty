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



###### 6. findomain

```

```

###### 





> Installation
> 
> Move all scripts to /opt/scripts directory
> 
> Export path variable permanently by add this command in .zshrc file 
> 
> - export PATH=$PATH:/opt/scripts  
> 
> Run scripts inside /opt/scripts


