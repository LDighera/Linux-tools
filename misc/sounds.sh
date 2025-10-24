#####!/usr/bin/ksh
# sounds.sh	Play all .wav files
#
# LGD: Wed Apr 19 09:02:27 PDT 2017
#

#set -x
trap exit INT QUIT
for i in `find / -name *.wav` ;do
  echo
  aplay $i
#  read -n 1 REPLY?"Return for next sound. Q to quit:"	# ksh only
  read -n 1 -p"Return for next sound. Q to quit:"	# bash only
  case $REPLY in
    [qQ]) exit	;;
    *) :	;;
  esac
done
