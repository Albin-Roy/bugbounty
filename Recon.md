# Reconnaissance

## Subdomain discovery

| Tools       | Speed     | Results                   |
| ----------- | --------- | ------------------------- |
| amass       | slow      | accurate but less results |
| subbrute    | very slow | accurate but less results |
| crtsh       | fast      | large results             |
| assetfinder | very fast | large results             |
| sublist3r   | fast      | large results             |
| findomain   | fast      | large results             |

##### 

Installation

Install crtsh, findomain and subbrute from github.

Move all scripts to /opt/scripts directory.

Export path variable permanently by add this command in .zshrc file.

- export PATH=$PATH:/opt/scripts

Run scripts inside /opt/scripts

Copy names.txt names_small.txt resolvers.txt from subbrute to where the script should run. 

##### Commands

###### 1. amass

```
amass enum -d <domain> >> amass.txt
```

###### 2. subbrute

```
subbrute.py <domain> >> subbrute.txt
```

###### 3. crtsh

```
crtsh.py -d <domain> >> crtsh.txt
```

###### 4. assetfinder

```
assetfinder --subs-only <domain> >> assetfinder.txt
```

###### 5. sublist3r

```
sublist3r -d <domain> -o sublister.txt
```

###### 6. findomain

```
findomain-linux -t <domain> -u findomain.txt
```

#### 

#### Combine Results

```
cat amass.txt assetfinder.txt crtsh.txt findomain.txt subbrute.txt sublister.txt >> SUBDOMAINS.txt
```

#### Removing Duplicates

```
cat subdomains.txt | sort -u > subdomains-UNIQUE.txt
```

#### Checking Alive

```
cat subdomains-UNIQUE.txt | httprobe -c 100 | sed 's/https\?:\/\///' > ALIVE.txt
```

## Scanning

```
nmap -iL ALIVE.txt -T5 -oA scans/scanned.txt > /dev/null 2>&1
```

### Taking screenshots using Eyewitness

```
eyewitness -f $pwd/ALIVE.txt -d screenshots
```
