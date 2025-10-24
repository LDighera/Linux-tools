# isitrunning.sh	This script will display the names of runing processes whose names are provided as an argument
#
# LGD: Sun 26 Jun 07:07:50 PDT 2016
#

if [[ $# -lt 1 ]] ;then	# If there's no argument, issue Usage message and exit
  echo -e "\n Usage: $0 [running process name]\n" >&2 
  exit 1
else
  ps -ef|grep $1|grep -v grep| grep -v $0 || echo "$1 Is not running" >&2
#  ps -ef|grep $1
fi

exit

