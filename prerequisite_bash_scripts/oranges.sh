#!/bin/bash

temp=30
if [ "$temp" -gt 28 ]; then
echo "CRITICAL ALERT: temperature is $temp degrees"
else
echo "NORMAL: temperature is $temp degrees"
fi
