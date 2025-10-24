# find_dirs.sh	Descend the directory tree and print directory names
#
# LGD: Fri Jul 17 15:45:04 PDT 2015
# LGD: Wed 29 Jun 06:47:11 PDT 2016 Added argument support
#

#set -x
# find .  -td 

[[ $1 == "-h" || $1 == "-?" || $1 == "--help" ]] && echo -e "\n\tUsage: $0 <root-dir> <dir-name>\n\n\t\
* with no arguments, all directories under current working directory are displayed\n\t\
* with one argument, all directories under the argument directory are displaed\n\t\
* with two arguments, all directories under the first argument with the name of the second argument are displayed\n" >&2 && exit 1

[[ $# -eq 0 ]] && find . -depth -type d			# Find all directories under current working directory

[[ $# -eq 1 ]] && find "${1:-.}" -depth -type d 		# Find all directories under directory provided as argument

[[ $# -eq 2 ]] && find "${1:-.}" -depth -type d  -name "$2"	# Find all directories under directory provided as argument 1 with name provided as argument 2
