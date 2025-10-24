# find_ls.sh	This script will provide an ls listing of the files provided as arguments
#
# LGD: Sun 12 Jun 11:46:53 PDT 2016
#

[[ $# -lt 2 ]] && echo -e "\n\tUsage: $0 <root-dir> <file-name> [file-name ...]\n" && exit 1 

DIR="$1"		# Save the first positional parameter
shift			# Remove the first positional parameter
#find "$DIR" -name "$@" -exec ls -l '{}' \;	# Display directory listings of file argument(s)
find "$DIR" -depth -name "$@" -exec echo "#### " '{}' \; -exec ls -l '{}' \;	# Display directory listings of file argument(s)
