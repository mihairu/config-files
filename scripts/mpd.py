#!/usr/bin/env python
# -*- coding: utf-8 -*-
import subprocess
import re

def run():
    p = subprocess.Popen(['mpc'],
        stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    return p

p = run()

playing = re.compile("\[playing\]");
paused = re.compile("\[paused\]");
founded = 0
output = ''

for line in p.stdout:
    for e in re.findall(playing, line):
        founded = 1
        out = ">>: "
    
    for e in re.findall(paused, line):
        founded = 1
        out = "||: "

    if founded:
        output = prev
    else:
        prev = line

if output == '':
    print '[]: not playing'
else:
    print out + output
