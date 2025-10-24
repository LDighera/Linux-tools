# cups_adm.sh	A script to facilitate CUPS printing system administration
#
# LGD: Sun 26 Feb 11:11:27 PST 2017
#

# It is necessary initally to edit /etc/cups/cupsd.conf and modify the "Restrict access..." section thusly:
#
#	# Restrict access to the admin pages ...
#	<Location /admin>
#	Order allow, deny
#	Allow localhost
#	</Location>
#

echo "Starting the CUPS printer system"
/etc/init.d/cups restart	# Restart CUPS printer system

#IP=$(ip addr show wlan0|grep "inet "|cut -d" "  -f6|cut -d/ -f)
#IP=$(hostname -I|cut -d" "  -f1)
#echo "Run `tput smso` http://${IP}:631 `tput rmso` to access the CUPS Administration System"

echo "Run `tput smso` http://localhost:631 `tput rmso` to access the CUPS Administration System"

read -n 1 REPLY?"`echo -e \"\nStart the X11 system now [Yn]? \c\"`"; echo ; [[ ${REPLY:-y} == [nN] ]] && exit
startx

