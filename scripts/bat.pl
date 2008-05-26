#!/usr/bin/env perl

##
# ACPI Battery Monitor Script for conky
# (c) 2006 BinaryShadow.org
# 
# Recommend compiling into bytecode with:
# $ perlcc -B -o bat bat.pl
##

use strict;
use warnings;

opendir(PROC_BATTERIES, '/proc/acpi/battery') or die;

my($tot_capacity,$cur_capacity,$curdir) = (0, 0, '');

while($curdir = readdir(PROC_BATTERIES)) {
  my($line) = '';
  if($curdir =~/^\./) {
    next;
  }
  open(BATTERY_STATE, '/proc/acpi/battery/'.$curdir.'/state') or next;
  while($line = <BATTERY_STATE>) {
    if($line =~/^present:\s+(yes|no)/) {
      if($1 eq 'yes') {
        while($line = <BATTERY_STATE>) {
          if($line =~/^remaining capacity:\s+([0-9]+)/) {
            $cur_capacity += $1;
            last;
          }
        }
        open(BATTERY_INFO, '/proc/acpi/battery/'.$curdir.'/info') or last;
        while($line = <BATTERY_INFO>) {
          if($line =~/^last full capacity:\s+([0-9]+)/) {
            $tot_capacity += $1;
            last;
          }
        }
        close(BATTERY_INFO);
      }
      last;
    }
  }
  close(BATTERY_STATE);
}

closedir(PROC_BATTERIES);

if ($tot_capacity != 0) {
	printf "%0.0f%s\n", (($cur_capacity / $tot_capacity) * 100, "%");
} else {
	print "0.0%\n";
}
