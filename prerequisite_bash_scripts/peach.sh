#!/bin/bash

count=0
while true; do
	count=$((count+1))
	echo "Count: $count"
	if [ $count -eq 5 ];then
		echo "stopping"
		break
	fi
done
echo "Loop Ended"
