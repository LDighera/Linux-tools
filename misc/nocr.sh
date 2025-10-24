# nocr
#	This script will strip carrage-return characters from its argument.
#
#	LGD: Mon 25 Jul 07:39:53 PDT 2016
#	LGS: Mon 16 Mar 2020 01:13:27 PM PDT Added ^Z character deletion
#

case $# in
	0)echo -e "\n$0: Usage: $0 [filename]"				;;
	1) cat $1 | tr -d "\r\032" > ${1}.nocr				;;
	*)echo -e "$0 accepts a single filename command-line argument: [filename]\n"	;;
esac
