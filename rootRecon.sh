#!/bin/bash

# Color variables
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'
# Clear the color after that
clr='\033[0m'

cd /root/bugbounty/targets/$1/rootDomains

arr=()
while IFS= read -r line; do
   arr+=("$line")
done </root/bugbounty/targets/$1/ALIVE.txt

for i in "${arr[@]}"
do
	if [ ! -d $i ]; then
		echo " "
		echo -e "${cyan}Scanning $i ${clr}"
		recon.sh $i
		echo -e "${green} $i completed..!${clr}"
	fi
done
