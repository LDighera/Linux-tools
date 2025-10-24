#
#	find_txt.sh	Searches a filesystem branch for files that contain the text string
#
#			Usage: find_txt.sh [root-dir] [text-string]
#				root=dir      The directory location from which to begin examining the contents of files.
#				text-string   The ASCII text being sought
#
# LGD: Fri 27 May 12:23:18 PDT 2016
# LGD: Sun 12 Jun 11:46:53 PDT 2016  Added root directory support
# LGD: Wed 02 Jun 2021 12:34:43 PM PDT  Attempted to call less only when text found.  find exit status always return 0!
#

# Set Options
GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'
GREP_OPTIONS='--color=auto --binary-files=without-match --directories=skip'

# USAGE
[[ $# -lt 2 ]] && echo -e "\n\tUsage: $0 [root-dir] [text-string]\n" >&2 && exit 1 

echo "Working ..."
 find "$1" -depth -type f -nowarn -exec grep -H "$2" '{}' \;|less   # Display file-names containing text-string and the line that contains it.  

exit

# Below work of June 2, 2021
find "$1" -depth -type f -nowarn -exec grep -H "$2" '{}' \; 
echo -e "'$?'=$?"

#|less   # Display file-names containing text-string and the line that contains it.  

exit
