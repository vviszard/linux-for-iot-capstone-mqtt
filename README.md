# Linux for IoT — Simulated MQTT Sensor Network

A Linux-based IoT pipeline built entirely in bash. A virtual temperature sensor publishes readings to an MQTT broker every 5 seconds, and a monitor subscribes to that feed and logs critical alerts to a file — all running simultaneously on a single Linux machine.

---

## Overview

This project implements the core pub/sub architecture that underlies most real-world IoT systems. Instead of physical hardware, a bash script simulates the sensor by generating random temperature values. The broker (Mosquitto) routes messages between the publisher and subscriber exactly as it would in a production deployment.

```
temp_sensor.sh  ──→  Mosquitto Broker (port 1883)  ──→  alert_system.sh
  (Publisher)              (Router)                       (Subscriber)
                                                               |
                                                               v
                                                   smart-home/logs/alerts.log
```

The only thing that would change on a real device is the data source inside `temp_sensor.sh` — the broker, the subscriber, and the alert logic would work without any modification.

---

## Repository Structure

```
linux-for-iot-capstone-mqtt/
│
├── smart-home/
│   ├── scripts/
│   │   ├── temp_sensor.sh       # Virtual temperature sensor — MQTT publisher
│   │   ├── alert_system.sh      # Alert monitor — MQTT subscriber and logger
│   │   └── README.txt
│   ├── logs/
│   │   └── alerts.log           # Written to at runtime
│   └── sensors/
│       └── sensor.conf          # Sensor configuration
│
└── prerequisite_bash_scripts/   # Bash concept scripts written along the way
    ├── hello.sh
    ├── apple.sh
    ├── banana.sh
    ├── grapes.sh
    ├── guava.sh
    ├── kiwi.sh
    ├── oranges.sh
    ├── peach.sh
    └── peanuts.sh
```

---

## Prerequisites

- Ubuntu (22.04 LTS or later) — bare metal or VM
- Mosquitto MQTT broker

```bash
sudo apt update
sudo apt install mosquitto mosquitto-clients -y
systemctl status mosquitto
```

Mosquitto starts automatically after installation and listens on `localhost:1883`.

---

## Running It

### Clone the repo

```bash
git clone https://github.com/vviszard/linux-for-iot-capstone-mqtt.git
cd linux-for-iot-capstone-mqtt
```

### Set up folders and permissions

```bash
mkdir -p ~/smart-home/scripts ~/smart-home/logs ~/smart-home/sensors
cp smart-home/scripts/* ~/smart-home/scripts/
cp smart-home/sensors/sensor.conf ~/smart-home/sensors/
chmod +x ~/smart-home/scripts/*.sh
cd ~/smart-home/scripts
```

### Run the sensor in the background

```bash
./temp_sensor.sh &
```

### Run the alert monitor

```bash
./alert_system.sh
```

### Watch the log file update live (optional, separate terminal)

```bash
tail -f ~/smart-home/logs/alerts.log
```

### Stop everything

```bash
# Ctrl+C to stop the alert monitor
kill %1
```

---

## The Scripts

### `temp_sensor.sh`

Runs an infinite loop. Every 5 seconds, generates a random integer between 20 and 29 and publishes it to the MQTT topic `home/temperature` via `mosquitto_pub`.

### `alert_system.sh`

Subscribes to `home/temperature` using `mosquitto_sub`, pipes the output into a `while read` loop, and appends a timestamped `CRITICAL ALERT` entry to `alerts.log` for any reading above 28°C.

---

## Prerequisite Scripts

Smaller scripts written while learning bash, each isolating one concept.

| Script | What it covers |
|---|---|
| `hello.sh` | Shebang, `echo`, comments, `$(date)` |
| `apple.sh` | Variables, `$RANDOM`, `$HOME`, `$USER`, command substitution |
| `banana.sh` | Script arguments — `$1`, `$2`, `$#`, `$@`, `$0` |
| `grapes.sh` | Arithmetic `$(( ))`, modulo, random ranges |
| `guava.sh` | `for` loop |
| `kiwi.sh` | `while true` + `sleep` — direct precursor to `temp_sensor.sh` |
| `oranges.sh` | `if/else` with `-gt` — direct precursor to `alert_system.sh` |
| `peach.sh` | `while` loop with counter and `break` |
| `peanuts.sh` | String comparison with `=` and `!=` |

---

## Built With

- Bash
- Mosquitto (MQTT broker)
- Ubuntu Linux
