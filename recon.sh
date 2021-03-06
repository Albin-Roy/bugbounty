#!/bin/bash

if [ $# -gt 2 ]; then
	echo "Usage: recon.sh <domain>"
	echo "Example: recon.sh sony.com"
	exit 1
fi


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
fi




