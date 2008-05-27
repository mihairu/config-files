#!/usr/bin/env python
# -*- coding: utf-8 -*-
import subprocess
import re

battery = "1"

charging = {"charging" : "^",
            "discharging" : "v",
            "charged" : "="}

battery = re.compile("Battery "+battery)
percent = re.compile("([0-9]+)%")
charge = re.compile("(([a-z]*)charg([a-z]+))")

def run():
    p = subprocess.Popen(['acpi', '-b'],
        stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    return p

p = run()

output = ''
for line in p.stdout:
    if re.findall(battery, line):
        for e in re.findall(charge, line):
            e = e[0]
            output = output + charging[e]
            break       
        for e in re.findall(percent, line):
           output = output + "|" + e + "%"
print 'bat:',
print output
