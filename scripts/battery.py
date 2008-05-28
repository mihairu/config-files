#!/usr/bin/env python
# -*- coding: utf-8 -*-
import subprocess
import re

battery = "1"

charging = {"Charging" : "^",
            "Discharging" : "v",
            "Charged" : "="}

battery = re.compile("Battery "+battery)
percent = re.compile("([0-9]+)%")
charge = re.compile("(([a-z]*)charg([a-z]+))")

def read_file(file):
    p = subprocess.Popen(['less', '/sys/class/power_supply/BAT0/'+file],
        stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    return p

status = read_file("status")

output = ''

# load battery status
for line in status.stdout:
    output += charging[line.split("\n")[0]]

# load battery percentage
energyNow = read_file("energy_now")
for line in energyNow.stdout:
    energyNow = line.split("\n")[0]

energyFull = read_file("energy_full")
for line in energyFull.stdout:
    energyFull = line.split("\n")[0]

energy = int(energyNow) / (int(energyFull)/100)
output += str(energy) + "%"


print 'bat:',
print output
