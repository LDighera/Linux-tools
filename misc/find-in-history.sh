# find-in-history.sh	Display historical commands
# LGD: Fri Jun 30 03:12:47 PDT 2017
#

#set -x	#DEBUG
STR="$1"
HSTDIR="/root/.history/"	# The directory that contains the .sh_history files

[[ $1 == "-h" || $1 == "-?" || $1 == "--help" || $# -lt 1 || $# -gt 1 ]] && echo -e "\n\tUsage: $0 <search string>\n" >&2 && exit 1

# grep -H -a "$STR" "$HSTDIR"/*|strings|grep -v history	# This still fails to print the file name(s) that contain a match.
grep -a "$STR" "$HSTDIR"/*|strings|grep -v history
