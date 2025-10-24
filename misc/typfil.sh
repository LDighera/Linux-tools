#
#	This file will enhance the type command by providing file-type info.
#	Copyright Dighera Data Services Sat Nov 12 15:36:00 PST 1988
#	Sat 14 Mar 2020 02:15:12 PM PDT LGD: Ported to Raspbian
#
#		The -d option turns on shell debugging (not really useful)
#		The -l option does an ls -l on the file
#

#set -x	#DEBUG

if [ $# -lt 1 ]
then
	echo "Usage: ${0} [-dl] file_name [...]"
	exit 1
fi

# parse options
case $1 in
	-w) WHAT=`what $1`;shift;;
	-s) STAT=`stat $1`;shift;;
	-d) set -xv;shift;;
	-l) LS=1;shift ;;
	-[dl]|-[ld]) LS=1;set -xv;shift;;
	*) ;;
esac

for i
do
	TYPE="`type $i`"
	FILE=`echo $TYPE|awk '{print $NF}'`	# print the last field
	if [ "$FILE" = "found" ]
	then
		echo -e "$TYPE\n"
		continue
	else
		if [ $LS ];then echo -e "\n"; ls -l $FILE;fi
		file $FILE
	fi
done
