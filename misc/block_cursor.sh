# block_cursor.sh	A script to make the cursor more visable
# LGD: Fri 22 Apr 09:48:10 PDT 2016
#

[[ $# -lt 1 ]] && tput cvvis	# Bright block cursor

[[ $1 == n ]] && tput cnorm	# Normal cursor
