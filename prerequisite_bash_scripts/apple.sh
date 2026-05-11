#!/bin/bash

device='raspberrypi'
echo $device
echo "device name is $device"
echo $RANDOM
echo $HOME
echo $PWD
echo $USER
echo $SHELL
now=$(date)
echo "the script started at: ${now}"
me=$(whoami)
echo "this file was writen by $me"
addr=$(hostname -I | awk '{print $1}')
echo "at $addr"
echo "that is exactly right at $(hostname -I)"
