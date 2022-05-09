#!/bin/bash

find /root/bugbounty/targets/$1/rootDomains/ -type f -name "ALIVE.txt" > /root/bugbounty/targets/$1/rootDomains/all-sub-path.txt
sleep 5
arr=()
while IFS= read -r line; do
   arr+=("$line")
done </root/bugbounty/targets/$1/rootDomains/all-sub-path.txt

indexes=( "${!arr[@]}" )
lastindex=${indexes[-1]}
lastindex=`expr $lastindex +  1`
count=1

for i in "${arr[@]}"
do
	cat $i >> /root/bugbounty/targets/$1/rootDomains/all-subdomains.txt
done
echo "All collected subdomains saved..!"
