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

indexes=( "${!arr[@]}" )
lastindex=${indexes[-1]}
lastindex=`expr $lastindex +  1`
count=1

for i in "${arr[@]}"
do
	if [ ! -d $i ]; then
		
		echo " "
		echo -e "${cyan}Scanning $i ${blue}       [ $count/$lastindex ] ${clr}"
		start_time=$(date +%s)
		recon.sh $i
		end_time=$(date +%s)
		echo -e "${red}$i completed in $(($end_time-$start_time)) seconds..!${clr}"
		if [ $count -eq $lastindex ];then
			echo -e "\n${yellow}Hurray!!! Completed reconnaissance on $1 ${clr}"
		fi
	fi
	count=`expr $count + 1`
done
