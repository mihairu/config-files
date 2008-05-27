#! /usr/bin/env python
# dotbak v0.1; backup important files or folders.
# by Daniel Campbell <daniel.l.campbell@gmail.com>
# Released under the GPLv3
#
# INSTRUCTIONS
#
# List the files you want to backup in ~/.dotbakrc. Make sure each file or
# folder is followed by a newline to ensure that it works properly. Then just
# run dotbak.

def main (file_list):
	import time
	files = []

	print "Files to backup:"
	print

	for line in file_list:
		line = line.strip()
		
		print "\t%s" % line
		files.append(line)

	file_spec = " ".join(files)
	status = 0
	while status == 0:
		print
		option = raw_input("Backup the files/folders listed above? (y/n) ")

		if option == "n":
			print
			print "Goodbye."
			return
		elif option == "y":
			archive = os.path.expandvars("$PWD") + "/dotbak-" + time.strftime("%Y-%m-%d") + ".tar.gz"
			print "The files will now be backed up."
			print os.system("tar -cvzf " + archive + " " + file_spec)
			print
			print "Backup complete. The archive may be found at " + archive
			status = 1
		else:
			print
			print "Error: Not a valid option. Please use (y)es or (n)o."

if __name__ == '__main__':
	import os

	try:
		fh = open(os.path.expandvars("$HOME") + "/.dotbakrc")
	except IOError:
		print "You have not created a list of files you want to backup. Create a .dotbakrc in your home directory if you want to use this tool."
	else:
		main(fh)
