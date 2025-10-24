# lp.sh		Print files
#
# LGD: Wed 29 Mar 15:40:28 PDT 2017
#

PRINTER=HP_LaserJet_400_color_M451dn
unset OPTION

# set -x		# DEBUG
# Valadate argument
[[ $1 == "-h" || $1 == "-?" || $1 == "--help" ]] && echo -e "\n\tUsage: $0 <image-file>" >&2 && exit 0		# Display help message
[[ $# -lt 1 ]] && echo -e "\n\tUsage: $0 <image-file>\n" >&2 && exit 1						# Display useage message
if [[ ! -s $1 ]] ;then												# Display invalid argument message
  echo -e "\n\t $0: File '$1' Either doesn't exist or is zero-length" >&2 
  exit 1
fi

MENU() {													# Function displays memue and prompts for user input
cat <<!

	1.  Landscape

	2.  Fit to page

	Q.  Done
!

read -n1 REPLY?"`echo -e \"\n\tPlease select from the above list [Q]? \c\"`";echo
return $REPLY
}

# Main program
while : ;do
  MENU
  case $REPLY in
    1) OPTION="$OPTION -o landscape"	;;
    2) OPTION="$OPTION -o fit-to-page"	;;
    [qQ]) break				;;
  esac
done

#echo -e "\n\tReady to print $1 on $PRINTER with options: $OPTION [Y/n]?\c"
read -n1 REPLY?"`echo -e \"\n\tReady to print $1 on $PRINTER with options: $OPTION [Y/n]? \c\"`";echo		# Prompt for user confirmation
[[ $REPLY == [Yy] ]] && lp -d $PRINTER $OPTION $1

exit

Additional informatin for future script development
# lp -d HP_LaserJet_400_color_M451dn -o landscape -o fit-to-page Desktop/MiramarBeachAerial.png

# lpoptions -p HP_LaserJet_400_color_M451dn -l
PageSize/Page Size: Custom.WIDTHxHEIGHT *Letter A4 11x17 A3 A5 B5 Env10 EnvC5 EnvDL EnvISOB5 EnvMonarch Executive Legal
InputSlot/Media Source: *Default Upper Lower Multipurpose Manual
Duplex/Double-Sided Printing: DuplexNoTumble DuplexTumble *None
Resolution/Resolution: 150x150dpi 300x300dpi *600x600dpi 1200x1200dpi

Above taken from this page: http://localhost:631/help/options.html
