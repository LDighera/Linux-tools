# LGD: August 25, 2025  Find-size.sh:   Find files larger than arg2
# LGD: September 7,  2025  Gemini AI rewrite

[[ $3 == DEBUG ]] && set -xv    # DEBUG

#
#       find-size.sh     Searches a filesystem branch for files of size greater than arg2
#
#                       Usage: find-size [root-dir] [file-size (kMG)] <DEBUG>
#                               root=dir      The directory location from which to begin examining files sizes.
#                               file-size in kelobytes, Magabytes, or Gigabytes
#                               DEBUG Show debugging information (optional)
#

[[ $3 == "DEBUG" ]] && set -xv          # DEBUG

# USAGE
[[ $# -lt 2 ]] && echo -e "\n\tUsage: $0 [root-dir] [file-size (kMG)] \n" >&2 && exit 1

# MAIN
echo "Working..."

# Extract the numeric part and scale from the size argument.
# 's' is numeric size, 'u' is unit ('k', 'M', or 'G').
size=$(echo "$2" | sed 's/[^0-9]//g')
unit=$(echo "$2" | sed 's/[0-9]//g')

# Convert everything to kilobytes for consistent comparison.
case "$unit" in
    k) min_kb=$size ;;
    M) min_kb=$((size * 1024)) ;;
    G) min_kb=$((size * 1024 * 1024)) ;;
    *) min_kb=$size ;; # Assumes kilobytes if no unit specified
esac

# Build the pipeline
OUTPUT=$(
  # Find all files and print size in kilobytes and path
  find "$1" -depth -type f 2>/dev/null -printf "%k %p\n" | \
  # Filter out files smaller than the minimum size
  awk -v min="$min_kb" '$1 > min' | \
  # Format the sizes for human-readable output
  numfmt --field=1 --from-unit=Ki --to=iec --padding=7 | \
  # Sort files by size, from largest to smallest
  sort -hr
)

# Display results with or without `less` paging
LINE_COUNT=$(echo "$OUTPUT" | wc -l)
if [[ "$LINE_COUNT" -gt 30 ]]; then
   echo "$OUTPUT" | less
else
   echo "$OUTPUT"
fi

exit

# Other options:
#
ls -lS          # long listing, sorted by size (largest first)
ls -lSr         # smallest first
ls -lSR         # recursive
find . -type f -exec ls -l -- {} + | sort -k5,5n        # smallest→largest
find . -type f -name '*.apk' -exec ls -l -- {} + | sort -k5,5nr



======================================================
# LGD: August 25, 2025  Find-size.sh:   Find files larger than arg2
# LGD: September 7,  2025  Gemini AI rewrite

[[ $3 == DEBUG ]] && set -xv    # DEBUG

#
#       find-size.sh     Searches a filesystem branch for files of size greater than arg2
#
#                       Usage: find-size [root-dir] [file-size (kMG)] <DEBUG>
#                               root=dir      The directory location from which to begin examining files sizes.
#                               file-size in kelobytes, Magabytes, or Gigabytes
#                               DEBUG Show debugging information (optional)
#

[[ $3 == "DEBUG" ]] && set -xv          # DEBUG

# USAGE
[[ $# -lt 2 ]] && echo -e "\n\tUsage: $0 [root-dir] [file-size (kMG)] \n" >&2 && exit 1

# MAIN
echo "Working..."

# Use `find` with `-printf` to format the output directly.
# %k gives size in kilobytes, %p gives the file path.
# We then use `numfmt` to convert the kilobytes to a human-readable format.
# `2>/dev/null` suppresses "Permission denied" errors.
OUTPUT=$(
  find "$1" -depth -type f -size "+$2" 2>/dev/null \
    -printf "%k %p\n" | \
    numfmt --field=1 --from-unit=Ki --to=iec --padding=7 | \
#     sort -h			# Sort files assending
    sort -h			# Sort files descending
)

# Display results with or without `less` paging, as you intended.
LINE_COUNT=$(echo "$OUTPUT" | wc -l)
if [[ "$LINE_COUNT" -gt 30 ]]; then
   echo "$OUTPUT" | less
else
   echo "$OUTPUT"
fi

exit


# LGD: August 25, 2025	Find-size.sh:	Find files larger than arg2

[[ $3 == DEBUG ]] && set -xv	# DEBUG

#
#       find-size.sh     Searches a filesystem branch for files of size greater than arg2
#
#                       Usage: find-size [root-dir] [file-size (kMG)] <DEBUG>
#                               root=dir      The directory location from which to begin examining files sizes.
#                               file-size in kelobytes, Magabytes, or Gigabytes
#                               DEBUG Show debugging information (optional)
#

[[ $3 == "DEBUG" ]] && set -xv		# DEBUG

# USAGE
[[ $# -lt 2 ]] && echo -e "\n\tUsage: $0 [root-dir] [file-size (kMG)] \n" >&2 && exit 1

FORMAT() {
  for i in $FOUND; do
    ls -hsS $i
  done |FOUND_FMT=$(
}


# MAIN
# find "$1" -depth -type f -nowarn -size "+$2"|/data/data/com.termux/files/usr/bin/less   # Display file-names .
# find "$1" -depth -type f -size "+$2"|/data/data/com.termux/files/usr/bin/less   # Display file-names on AndroidTV.
# find "$1" -depth -type f -size "+$2"|less	# Display file-names on Debian.
echo Working ...		# Never presenta a blank screen to the user.
FOUND=$(find "$1" -depth -type f -size "+$2" 2>/dev/null)	# Find the big files and supress errors/warnings.

# Only pipe output through less when necessary
if [[ `echo "$FOUND"|wc -l` -gt 30 ]] ;then
   echo "$FOUND" | less
else
  [[ `echo "$FOUND"|wc -l` -le 30 ]] && echo "$FOUND"
fi

exit

-size n[cwbkMG]
              File uses less than, more than or exactly n units of space,
              rounding up.  The following suffixes can be used:

              `b'    for 512-byte blocks (this is the default if no suffix is                                                                                 used)

              `c'    for bytes                                                                                                           
              `w'    for two-byte words

              `k'    for kibibytes (KiB, units of 1024 bytes)

              `M'    for mebibytes (MiB, units of 1024 * 1024 = 1048576 bytes)

              `G'    for gibibytes (GiB, units of 1024 * 1024 * 1024 =
                     1073741824 bytes)

              The size is simply the st_size member of the struct stat
              populated by the lstat (or stat) system call, rounded up as
              shown above.  In other words, it's consistent with the result
              you get for ls -l.  Bear in mind that the `%k' and `%b' format
              specifiers of -printf handle sparse files differently.  The `b'
              suffix always denotes 512-byte blocks and never 1024-byte
              blocks, which is different to the behaviour of -ls.
                                                                                                                                                       The + and - prefixes signify greater than and less than, as
              usual; i.e., an exact size of n units does not match.  Bear in
              mind that the size is rounded up to the next unit.  Therefore                                                                            -size -1M is not equivalent to -size -1048576c.  The former only
              matches empty files, the latter matches files from 0 to
              1,048,575 bytes.
