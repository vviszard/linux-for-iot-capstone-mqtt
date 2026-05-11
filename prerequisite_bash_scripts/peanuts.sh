#!/bin/bash

status="online"

if [ "$status" = "online" ]; then
echo "DEVICE IS CONNECTED"
fi

if [ "$status" != "offline" ]; then
echo "NOT ONLINE"
fi
