# Linux for IoT Capstone Project
### Simulated Smart Home Sensor Network using MQTT on Linux

> A hands-on workshop project by the **Centre of Excellence in IoT and Measurement Science** 
> Participants build a working IoT pipeline entirely on Linux using bash scripting and the MQTT protocol.

---

## What This Project Does

By the end of this workshop, participants run two bash scripts simultaneously on their Linux VM:

- A **virtual temperature sensor** that generates random readings every 5 seconds and publishes them to an MQTT broker
- An **alert monitor** that receives those readings in real time and logs a `CRITICAL ALERT` to a file whenever temperature exceeds 28C

This is the same **Publish Broker Subscribe** architecture used by AWS IoT, Azure IoT Hub, and every major commercial IoT platform built entirely from first principles in bash.

```
temp_sensor.sh Mosquitto Broker (port 1883) alert_system.sh
 (Publisher) (Router) (Subscriber)
 
 
 ~/smart-home/logs/alerts.log
```

---

## Repository Structure

```
linux-for-iot-capstone-mqtt/

 smart-home/
 scripts/
 temp_sensor.sh # Virtual MQTT temperature sensor (publisher)
 alert_system.sh # MQTT alert monitor (subscriber + logger)
 README.txt # Project notes
 logs/
 alerts.log # Alert log written to during runtime
 sensors/
 sensor.conf # Sensor configuration file

 prerequisite_bash_scripts/ # Practice scripts from Day 1 & 2 sessions
 hello.sh # First script echo, comments, date
 apple.sh # Variables, built-ins, command substitution
 banana.sh # Script arguments ($1, $2, $@, $#)
 grapes.sh # Arithmetic expansion $(( ))
 guava.sh # for loop
 kiwi.sh # while loop + sleep (sensor skeleton)
 oranges.sh # if/else with integer comparison
 peach.sh # while loop + break
 peanuts.sh # String comparison if/if-not
```

---

## Prerequisites

### System
- Ubuntu Desktop (22.04 LTS or later) bare metal or VirtualBox VM
- A terminal (Ctrl+Alt+T)

### Software to install before starting

```bash
# 1. Update package list
sudo apt update

# 2. Install Mosquitto (MQTT broker + CLI tools)
sudo apt install mosquitto mosquitto-clients -y

# 3. Verify the broker started automatically
systemctl status mosquitto
```

You should see `Active: active (running)`. Mosquitto is now running on `localhost:1883` and will start automatically on every boot.

---

## How to Run the Capstone

### Step 1 Clone the repository

```bash
git clone https://github.com/vviszard/linux-for-iot-capstone-mqtt.git
cd linux-for-iot-capstone-mqtt
```

### Step 2 Set up the project folders

```bash
mkdir -p ~/smart-home/scripts ~/smart-home/logs ~/smart-home/sensors
cp smart-home/scripts/* ~/smart-home/scripts/
cp smart-home/sensors/sensor.conf ~/smart-home/sensors/
chmod +x ~/smart-home/scripts/*.sh
```

### Step 3 Run the sensor in the background

```bash
cd ~/smart-home/scripts
./temp_sensor.sh &
```

You'll see timestamped temperature readings every 5 seconds. The `&` sends it to the background so you can keep using the terminal.

### Step 4 Run the alert monitor in the foreground

```bash
./alert_system.sh
```

You'll see `OK` lines for normal readings and `CRITICAL ALERT` lines for anything above 28C.

### Step 5 Watch the log file update live (optional, third terminal)

```bash
tail -f ~/smart-home/logs/alerts.log
```

### Step 6 Stop everything

```bash
# Ctrl+C to stop the alert monitor
kill %1 # stops the background sensor
jobs # verify nothing is running
```

---

## Prerequisite Scripts What Each One Teaches

These scripts were written during the Day 1 and Day 2 sessions as participants learned each concept. They build up to the capstone.

| Script | Concept Demonstrated |
|---|---|
| `hello.sh` | Shebang, `echo`, comments, command substitution with `$(date)` |
| `apple.sh` | Variables, built-in variables (`$RANDOM`, `$HOME`, `$USER`, `$PWD`, `$SHELL`), command substitution |
| `banana.sh` | Script arguments: `$1`, `$2`, `$#`, `$@`, `$0` |
| `grapes.sh` | Arithmetic expansion `$(( ))`, modulo `%`, random number range |
| `guava.sh` | `for` loop over a list |
| `kiwi.sh` | `while true` infinite loop + `sleep` the skeleton of `temp_sensor.sh` |
| `oranges.sh` | `if/else` with integer comparison (`-gt`) the skeleton of `alert_system.sh` |
| `peach.sh` | `while` loop with a counter, `break` to exit early |
| `peanuts.sh` | String comparison (`=` and `!=`) in `if` statements |

---

## The Two Capstone Scripts

### `temp_sensor.sh` The Publisher

Simulates a temperature sensor. Every 5 seconds, generates a random integer between 2029C and publishes it to the MQTT topic `home/temperature` via Mosquitto.

```bash
./temp_sensor.sh # run interactively (Ctrl+C to stop)
./temp_sensor.sh & # run in background (use during capstone)
```

### `alert_system.sh` The Subscriber

Subscribes to `home/temperature`. Reads each incoming value through a `while read` pipe loop. If the value exceeds 28C, it logs a `CRITICAL ALERT` to `~/smart-home/logs/alerts.log`.

```bash
./alert_system.sh # run in foreground while sensor runs in background
```

---

## Concepts This Project Covers

- Linux terminal navigation and file operations
- File permissions `chmod`, `chown`
- Package management `apt`
- Processes and background jobs `&`, `jobs`, `kill`, `systemctl`
- Bash scripting variables, arithmetic, conditionals, loops, pipes
- Networking basics IP addresses, ports, `ss`, SSH
- **MQTT protocol** pub/sub model, broker, topics, Mosquitto

---

## About

This project is part of the **Linux for IoT** workshop organised by the 
**Centre of Excellence in IoT and Measurement Science**.

The workshop takes participants from zero Linux experience to running a complete IoT sensor pipeline in two days, using only open-source tools on Ubuntu.

---

*Made with bash and by the IoT CoE team*
