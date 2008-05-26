#!/usr/bin/env python
# -*- coding: utf-8 -*-

import subprocess
from glob import glob

# what partition do you want to check?
hdd = ('sda6', 'sda7', 'sda5', 'sda4')

# open process df
p = subprocess.Popen(['df'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
dfout = []
for line in p.stdout:
    dfout.append(line)

# search partitions
dfout = dfout[1:]
tmpoutput = {}
output = []
for i in dfout:
    for hddi in hdd:
        if i.startswith("/dev/"+hddi):
            tmpoutput[hddi] = i.split(" ")[-2]

# sort by hdd
for i in hdd:
    output.append(tmpoutput[i])

# print output - style int%|int$
print "|".join(output)
