#!/usr/bin/env python
# -*- coding: utf-8 -*-
import subprocess
import re

wifi = "wlan0"

def run():
    p = subprocess.Popen(['iwconfig', wifi],
        stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    return p

p = run()

essid = re.compile("ESSID:\"([a-z\-]*)\"")
quality = re.compile("Link Quality=([0-9]*)\/100")

qualityout = ''
essidout = ''

for line in p.stdout:
    for e in re.findall(essid, line):
        essidout = e

    for e in re.findall(quality, line):
        qualityout = e

if essidout == '' or qualityout == '':
    print "no connection"
else:
    print essidout + " [" + qualityout + "%]"
