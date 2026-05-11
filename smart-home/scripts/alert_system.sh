#!/bin/bash

#alert system MQTT subscriber.

TOPIC="home/temperature"
BROKER="localhost"
LOG_FILE="$HOME/smart-home/logs/alerts.log"
THRESHOLD=28

echo "Alert system starting."
echo "Monitoring Topic: $TOPIC"
echo "Alert Threshold: ${THRESHOLD} degrees Celcius"
echo "Log file: $LOG_FILE"
echo ""
mosquitto_sub -h "$BROKER" -t "$TOPIC" | while read temp; do

	now=$(date "+%Y-%m-%d %H:%M:%S")

	if [ "$temp" -gt "$THRESHOLD" ]; then
		alert_message="[$now] CRITICAL ALERT: Temperature is ${temp} degrees Celcius (threshold: $THRESHOLD degrees Celcius)"
		echo "$alert_message"
		echo "$alert_message >> $LOG_FILE"
	else
		echo "[$now] OK: ${temp} degrees Celcius"
	fi

done
