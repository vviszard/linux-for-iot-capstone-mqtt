#!/bin/bash

while true; do
	temp=$((20 + RANDOM % 10))
	echo "Temperature is: $temp degrees"
	sleep 2
done
