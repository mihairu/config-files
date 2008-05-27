#!/usr/bin/python

import feedparser as fp
import sys

feed = fp.parse(sys.argv[1]) 
lines = int(sys.argv[2])

for i in range(lines):
    entries = feed.entries[i]
    title = entries.title[:100]
    print '%s' % title
