path=$(find / -type d -name $1 2>/dev/null)
if [ -z "$path"  ]
then
echo "Empty"
else
echo "not empty"
fi
