#!/bin/bash

awk '$0="http://"$0' /root/bugbounty/targets/$1/rootDomains/all-subdomains.txt > /root/bugbounty/targets/$1/rootDomains/httpcheck.txt
echo "Checking http status codes using medic"
medic /root/bugbounty/targets/$1/rootDomains/httpcheck.txt >> /root/bugbounty/targets/$1/rootDomains/statuscodes.txt
cat /root/bugbounty/targets/$1/rootDomains/statuscodes.txt | grep "403 " >> /root/bugbounty/targets/$1/rootDomains/403and401.txt
cat /root/bugbounty/targets/$1/rootDomains/statuscodes.txt | grep "401 " >> /root/bugbounty/targets/$1/rootDomains/403and401.txt
awk -F "http" '{print "http"$2}' /root/bugbounty/targets/$1/rootDomains/403and401.txt | sort -u > /root/bugbounty/targets/$1/rootDomains/forbidden.txt

arr=()
while IFS= read -r line; do
   arr+=("$line")
done </root/bugbounty/targets/$1/rootDomains/forbidden.txt

indexes=( "${!arr[@]}" )
lastindex=${indexes[-1]}
lastindex=`expr $lastindex +  1`
count=1

for i in "${arr[@]}"
do
	echo ""
	echo "$i" >> /root/bugbounty/targets/$1/rootDomains/403bypass.txt
	echo -e "Scanning $i           [ $count/$lastindex ] "
	byp4xx.py -L $i >> /root/bugbounty/targets/$1/rootDomains/403bypass.txt
	echo -e "\n\n" >> /root/bugbounty/targets/$1/rootDomains/403bypass.txt
	count=`expr $count + 1`
done
echo "All subdomains scanned..!"
