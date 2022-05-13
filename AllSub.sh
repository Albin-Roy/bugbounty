#!/bin/bash

#collects all alive subdomains and combine it into a single file

find /root/bugbounty/targets/$1/root_domains/ -type f -name "ALIVE.txt" > /root/bugbounty/targets/$1/root_domains/all-sub-path.txt
sleep 5
arr=()
while IFS= read -r line; do
   arr+=("$line")
done </root/bugbounty/targets/$1/root_domains/all-sub-path.txt

indexes=( "${!arr[@]}" )
lastindex=${indexes[-1]}
lastindex=`expr $lastindex +  1`
count=1

for i in "${arr[@]}"
do
	cat $i >> /root/bugbounty/targets/$1/root_domains/all-subdomains.txt
done
echo "All collected subdomains saved..!"
