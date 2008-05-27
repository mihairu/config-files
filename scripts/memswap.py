#!/usr/bin/env python
# -*- coding: utf-8 -*-

import time
INTERVAL = 1

def getValues():
    dict = []
    statFile = file("/proc/meminfo", "r")
    for line in statFile.readlines():
        data = line.split(" ")[-2]
        if line.startswith("MemTotal:"):
            memtotal = data
        if line.startswith("MemFree:"):
            memfree = data
        if line.startswith("Cached:"):
            cached = data
        if line.startswith("Buffers:"):
            buffers = data
        if line.startswith("SwapTotal:"):
            swaptotal = data
        if line.startswith("SwapFree:"):
            swapfree = data
    mem = str(100 - (int(memfree)+int(cached)+int(buffers))/(int(memtotal)/100)) + "%"
    swap = str(100 - int(swapfree)/(int(swaptotal)/100)) + "%"
    print '%s|%s' % (mem, swap)

print 'mem:',
getValues()
