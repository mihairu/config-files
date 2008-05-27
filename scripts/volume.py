#!/usr/bin/env python
# -*- coding: utf-8 -*-
import subprocess
import re

channel = "PCM"

percent = re.compile("\[([0-9]+)%\]")
chan = re.compile("Front Left:")
def run():
    p = subprocess.Popen(['amixer', 'get', channel],
        stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    return p

p = run()

for line in p.stdout:
    if re.findall(chan, line):
        for e in re.findall(percent, line):
            print "vol: " + e + "%"
