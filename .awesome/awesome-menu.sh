#!/bin/bash
prog="abiword
abook
alarm_mp3
alsamixer
amazing
amixer
audacious
audacity
awesome-status
awesome-client
bash
bashbug
bashcolors
cal_pixresizer
crrcsim
cscope
ding
eject
elinks-start
emerge
fetchmail
ffox
ffox2
fritz
fvwmsetbg
gimp
gimptool-2.0
gitk
gnubg
gqview
gtk-config
jhead
killall
ktelnet
lftp
lftpget
logout
lynx
mc
mcview
mkbackupbig
mkbackuplittle
mkems
mkgetvideo
mkscreen
mozilla
mplayer
mplayer-start
mutt
mutt-start
mutt_theme_color
nano
nitrogen /storage/Wallpapers
osd_cat_clock
osd_fetchmail_hint
perl
pgawk
pps
python
restart
rxvt
sajberplay
sandbox
screen
shutdown
softtax.bin
ssh
sunclock
telnet
traceroute
tvbrowser
weechat-curses
xpdf
urxvtc
xvkbd
xxd
xxdiff
zsh"

#cmd=$(dmenu -b -nb '#000008' -nf '#669933' -sb '#001111' -sf '#99cc99' -fn "-*-*-*-*-*-*-20-*-*-*-*-*-*-*" <<< "$prog")
cmd=$(awesome-menu ">" <<< "$prog")

case ${cmd%% *} in
  urxvt)    awesome-client <<< "0 spawn urxvt -ls";;
  python|telnet|traceroute|elinks-start|lynx|vim|mutt|weechat-curses|slrn|mc|killall)
            awesome-client <<< "0 spawn urxvt -tn "${TERM}" -e '${cmd}'";;
  logout)   awesome-client <<< "0 quit";;
  shutdown) awesome-client <<< "0 spawn urxvt -tn "${TERM}" -e '/sbin/halt'";;
  restart)  awesome-client <<< "0 spawn urxvt -tn "${TERM}" -e '/sbin/shutdown -r'";;
  *)        awesome-client <<< "0 spawn '${cmd}'";;
esac
