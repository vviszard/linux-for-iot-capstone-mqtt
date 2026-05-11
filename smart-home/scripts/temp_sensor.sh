#!/bin/bash

#virtual temperature sensor

TOPIC="home/temperature"
BROKER="localhost"
INTERVAL=5

echo "Sensor starting up. Publishing to: $TOPIC"
echo "Press Ctrl+C to stop."

while true; do
	temp=$((20 + RANDOM % 10))
	now=$(date "+%H:%M:%S")

	mosquitto_pub -h "$BROKER" -t "$TOPIC" -m "$temp" #publish to MQTT Broker

	if [ "$temp" -gt 25 ]; then
		echo "[$now] Published: ${temp} degree Celcius <- HIGH"
	else
		echo "[$now] Published: ${temp} degree Celcius"
	fi
	sleep $INTERVAL
done

