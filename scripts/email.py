#!/usr/bin/env python
# -*- coding: utf-8 -*-

from glob import glob
import re

print 'mail:',
########### SETTINGS
# location of mailbox
directory = "/home/mihairu/Mailbox/";
# show keywords
showKeywords = True
# only keywords line?
onlyKeywords = True
# keywords setting // order by importance
keywords = (
        {'Mailing lists':'ML'},
        {'personal':'P'},
        {'school':'S'},
        {'work':'W'},
        {'njnet':'NJ'},
        )
width = 50

########### INIT
mailcount = {}

########### MAIN

i = 0
for x in glob(directory+"*/*/new/*"):
    found = False
    for num,z in enumerate(keywords):
        for y in z: 
            if y in x:
                keyword = keywords[num][y]
                if keyword not in mailcount.keys():
                    mailcount[keyword] = 1
                    found = True
                    break
                else:
                    mailcount[keyword] += 1
                    found = True
                    break
        if found: break
    i+=1

if (i==0):
    string = 'No mail'
else: 
    if (i>1):
        postfix = "(s)"
    else:
        postfix = "";
    string = '%i new mail%s' % (i, postfix)
    string.ljust(width)

if (onlyKeywords and showKeywords):
    if len(mailcount.keys())==0:
        print string
    for x in mailcount.keys():
        print '%s:%s' % (x,mailcount[x]),
elif onlyKeywords:
    print string
    if showKeywords:
        for x in mailcount.keys():
            print '%s:%s' % (x,mailcount[x]),
                
