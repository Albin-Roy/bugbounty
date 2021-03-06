#!/bin/bash


recon () {
	if [ ! -d $1 ]; then
		mkdir $1
		cd $1
		if [ ! -d "scans" ]; then
			mkdir scans
		fi


		pwd=$(pwd)
		sleep 2

		echo "Gathering information from amass..."
		amass enum -d $1 -o amass.txt > /dev/null 2>&1
		sleep 5

		echo "Gathering information from crtsh..."
		crtsh.py -d $1 >> crtsh.txt
		sleep 5

		echo "Gathering information from assetfinder..."
		assetfinder --subs-only $1 >> assetfinder.txt
		sleep 5

		echo "Gathering information from sublist3r..."
		sublist3r -d $1 -o sublister.txt > /dev/null 2>&1
		sleep 5

		echo "Gathering information form findomain..."
		findomain-linux -t $1 -u findomain.txt > /dev/null 2>&1
		sleep 5

		echo "Combining results..."
		cat amass.txt assetfinder.txt crtsh.txt findomain.txt sublister.txt >> SUBDOMAINS.txt
		sleep 5

		echo "Removing duplicates..."
		cat SUBDOMAINS.txt | sort -u > subdomains-UNIQUE.txt
		sleep 5

		echo "Checking alive targets..."
		cat subdomains-UNIQUE.txt | httprobe -c 100 | sed 's/https\?:\/\///' > ALIVE.txt
		sleep 5

		echo  "Scanning for open ports..."
		nmap -iL ALIVE.txt -T5 -oA scans/scanned.txt > /dev/null 2>&1
		sleep 5

		echo "Taking screenshots..."
		eyewitness -f $pwd/ALIVE.txt -d screenshots --no-prompt > /dev/null 2>&1
		cd ..
	fi

}




# Color variables
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'
clr='\033[0m'

if [ ! -f $1 ];then
		echo "Please provide a text file containing assets to scan..!"
		echo "Example: autorecon.sh assets.txt"
else
		pwd=$(pwd)

		arr=()
		while IFS= read -r line; do
		arr+=("$line")
		done <$pwd/$1

		if [ ! -d root_domains ]; then
				mkdir root_domains
				cd root_domains
		else
				cd root_domains
		fi

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
				recon "$i"
				end_time=$(date +%s)
				echo -e "${red}$i completed in $(($end_time-$start_time)) seconds..!${clr}"
				if [ $count -eq $lastindex ];then
					echo -e "\n${yellow}Hurray!!! Completed reconnaissance ${clr}"
				fi
			fi
			count=`expr $count + 1`
		done
	fi






