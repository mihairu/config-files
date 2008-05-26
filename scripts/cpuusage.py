#!/usr/bin/env python
# -*- coding: utf-8 -*-

from glob import glob

# how many processors do you have?
nocpu = 2

# output init
output = ''

def getValues(cpu):
    tmpVal = []
    procVal = []

    procFile = file("/proc/stat", "r")
    
    # tmp file exists?
    if glob('/tmp/cpuscript'):
        tmpFile = file("/tmp/cpuscript", "r")
    else:
        tmpFile = file("/proc/stat", "r")

    # load datas from tmpFile and procFile
    for line in procFile.readlines()[cpu].split(" ")[0:6]:
        procVal.append(line)
    
    for line in tmpFile.readlines()[cpu].split(" ")[0:6]:
        tmpVal.append(line)

    # close files, erase
    procFile.close()
    tmpFile.close()
    procFile = tmpFile = copyFile = ''

    return getPercentage(tmpVal, procVal)

def getPercentage(data, dict):
    u = int(dict[1]) - int(data[1])
    n = int(dict[2]) - int(data[2])
    s = int(dict[3]) - int(data[3])
    usage = u+n+s
    total = usage + (int(dict[4]) - int(data[4]))
    if total == 0:
        total = 1
    return str((100*usage)/total) + '%'

def saveTmp():
    # /proc/stat => /tmp/cpuscript
    copyFile = file("/tmp/cpuscript", "w")
    procFile = file("/proc/stat", "r")
    for line in procFile.readlines():
        copyFile.writelines(line)
    copyFile.close()


# main loop {{{
output = []
for i in range(nocpu):
    output.append(getValues(i+1))
# }}}

# and then...save /proc/stat
saveTmp()

# print output - style int%|int$
print "|".join(output)
