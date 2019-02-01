#!/bin/sh

#FONT="-windows-montecarlo-medium-r-normal--11-110-72-72-c-60-microsoft-cp1252"

WIDTH=$(xrandr | head -1 | perl -pe 's/^.+current (\d+) x (\d+).+$/$1 $2/' | awk '{print $1}')

while true; do
  perl dzen_1080x1920.pl
  sleep 1
done|dzen2  -x 0 -y 0 -w $WIDTH -ta c -sa l -bg '#121212'
