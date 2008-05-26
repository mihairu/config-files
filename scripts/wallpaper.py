#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import random

pathWallpapers = '/home/majkhii/wallpapers/'
dir = os.listdir(pathWallpapers)

count = len(dir)

# nahodne cislo
choice = random.randrange(0, count)

os.system('feh --bg-scale %s%s' % \
        (pathWallpapers, dir[choice]))
