import subprocess

def mocinfo():
    p = subprocess.Popen(['mocp','-i'],
            stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    return p

def parse(info):
    a = {}
    for line in info.stdout:
        print line
        if line.startswith('Artist:'):
            artist = line.split()[1:]
            print artist
            a['artist'] = artist
        
        if line.startswith('Album:'):
            album = line.split()[1:]
            a['album'] = album
        if line.startswith('SongTitle:'):
            song = line.split()[1:]
            a['song'] = song



        return a

a = parse(mocinfo())
print a
