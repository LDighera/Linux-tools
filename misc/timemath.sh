#! /usr/bin/ksh
#
#	This script will perform sum and difference asthmatic
#	on a time and an in/decrement in 24 hour format.
#	It accepts a single option, -a, which displays the time
#	in twenty-four hour format that is compatible with the
#	the UNIX at command (eg. 00:00) without any sign or 
#	day display.  It appears to handle arbitrary time values
#	with perspicacity.  
#	
#	Version: 0.9 beta
#	Send updates to: ...!uunet!ccicpg!conexch!root  ...!uunet!mtndew!conexch!root
#	Copyright Dighera Data Services Mon Aug 23 20:47:27 PDT 1993
#
#	/bin/date '+%_A, %B %-d, %Y %H%M %Z'
#	LGD Tue 05 May 2020 09:20:15 AM PDT: Attempt to update. Output display still requires work.
#

# set -xv DEBUG

##	Parse positional parameters
# Display Usage if positional parameters incorrect
if [ $# -gt 4 -o $# -lt 3 ] ;then
  $(echo -e "\nUsage: `basename $0` [-a] HH:MM +|- hh:mm\n\tWhere HH:MM = time, + or -, & hh:mm = increment/decrement; -a = at format\n" >&2)
  exit 1
fi

DAYS=""
AT=0						# at command display format off
j=0
for i in $@
do
	# Vlad?  Permit only digits, +, -, and a.
	if [ "$i" != `echo "$i" | tr -d "[\001-\052],./[\073-\140][\142-\177]"` ] 
	then
		echo "$0: bad pram $i" >&2;exit 2
	fi

	if   echo $i | grep : >/dev/null	# Is this pram a time?
	then					# Store times in variables
		j=`expr $j + 1`
		let HH${j}="`echo $i | awk  -F\":\" '{ print $1 }'`" #|| exit 3
		let MM${j}="`echo $i | awk  -F\":\" '{ print $2 }'`" #|| exit 4
	elif [ $i = - -o $i = + ]		# Is this pram a sign?
	then					# Store sign in variable
		SIGN=$i
	elif [ $i = "-a" ]			# Is this parm the option
	then
		AT=1				# at command display-format on
	else
		echo -e "\n`basename $0`: Bad parameter $i" >&2	# This parm is invalid; quit.
		exit 5
	fi
done

#set -vx

## Calculate minutes first.
MINUTES=`expr $MM1 $SIGN $MM2`			# Total the minutes.
HRS_PER_MINS=`expr $MINUTES / 60`		# number of hours in MINUTES?
if   [ $MINUTES -le 59 -a $MINUTES -ge -59 ]	# These are valid MINUTE times. 
then						# Let them fall through.
	:
else 						# These are invalid MINUTE times
	MINUTES=`expr $MINUTES - 60 \* $HRS_PER_MINS`  # Minutes roll-over/under
fi

## Calculate hours next.
HOURS=`expr \( $HH1 $SIGN $HH2 \) + $HRS_PER_MINS` 	# Total the hours.
if   [ $HOURS -lt 24 -a $HOURS -gt -24 ]	# A number between +23 & -23.
then						# These are valid hours.
	:					# Let HOURS fall through.
else		 				# Invalid HOURS; adjust DAYS
	DAYS=`expr $HOURS / 24`			 
	HOURS=`expr $HOURS - 24 \* $DAYS`	# Hours roll-over/under.
fi

## Format the minutes for display.
COUNT=`echo $MINUTES | wc -c`			# Is it a 0 or 00 or -0 or ...?
if   [ $MINUTES -eq 0 ]				# Correct zero minute format.
then
	MINUTES=00
elif [ $COUNT -lt 3 -a $MINUTES -ge 0 ]		# Is it a single positive digit?
then
	MINUTES=0$MINUTES			# Correct single + minute format
# Avoid Minute error trap
elif   [ $MINUTES -lt 60 -a $MINUTES -gt -60 ]	# These are valid MINUTES times 
then
	:					# Let MINUTES fall through.
else
	echo -e "\n`basename $0`: Minute error" >&2; exit 7
fi

## Format the hours for display (Hours are: greater than -24 & less than 24)
COUNT=`echo $HOURS | wc -c`			# Is it a 0 or 00 or -0 or ...?
if   [ $HOURS -eq 0 ]				# Correction to hour format.
then
	HOURS=00
elif [ $HOURS -ge 0 -a $COUNT -lt 3 ]		# Is it a single positive digit?
then
	HOURS=0$HOURS				# Format single positive digits.
elif [ $HOURS -lt 0 -a $COUNT -eq 3 ]		# Is it a single negative digit?
then
	HOURS=`echo $HOURS | sed s/-/-0/`	# Format single negative digits.
# Avoid Hour error trap
elif  [ $HOURS -lt 24 -a $HOURS -gt -24 ]	# A number between 23 and -23.
then
	:					# These are valid hours.
else
	echo -e "\n`basename $0`: Hour error" >&2; exit 8
fi

## Display output.
if [ $AT -eq 1 ]
then
	# Display time in at command format.  Additional progromming required per 'at' time format described at the end of this file.
	if [ $HOURS -lt 0 ]
	then						# Force HOURS positive.
		HOURS="`expr $HOURS + 24`"		# Barrow a day's hours
	fi
	if [ $MINUTES -lt 0 ]
	then
		MINUTES="`expr 60 + $MINUTES`"		# 
		if [ $HOURS -eq 23 ]
		then
			HOURS=00
		fi
	fi
	echo -e "\n\t${HOURS}:${MINUTES}\n"		# Display time
else
set -x DEBUG
	# Is it plural?
	D=days;if [ "$DAYS" -eq 1 -o "$DAYS" -eq -1 ]; then D=day;fi		# Correct grammer
	# Display days, hours, and minutes.
#	echo -e "\n\t$(if [ -n "${DAYS}" ] ;then echo -n "${DAYS} $D ";fi)${HOURS}:${MINUTES}\n"	# Math wrong here BUG
	echo -e "\n\t$(if [ -n "${DAYS}" ] ;then echo -n "${DAYS} $D ";fi)${HOURS}:${MINUTES}\n"	# Math wrong here BUG
fi

set +x

exit 0

       At  allows  fairly  complex time specifications, extending the POSIX.2 stan‐
       dard.  It accepts times of the form HH:MM to run a job at a specific time of
       day.  (If that time is already past, the next day is assumed.)  You may also
       specify midnight, noon, or teatime (4pm) and you can have a time-of-day suf‐
       fixed with AM or PM for running in the morning or the evening.  You can also
       say what day the job will be run, by giving a date in  the  form  month-name
       day  with  an  optional  year,  or  giving  a  date  of the form MMDD[CC]YY,
       MM/DD/[CC]YY, DD.MM.[CC]YY or [CC]YY-MM-DD.  The  specification  of  a  date
       must  follow  the specification of the time of day.  You can also give times
       like now + count time-units, where the time-units  can  be  minutes,  hours,
       days,  or  weeks  and  you can tell at to run the job today by suffixing the
       time with today and to run the job tomorrow by suffixing the time  with  to‐
       morrow.

       For  example, to run a job at 4pm three days from now, you would do at 4pm +
       3 days, to run a job at 10:00am on July 31, you would do at 10am Jul 31  and
       to run a job at 1am tomorrow, you would do at 1am tomorrow.

       If  you  specify  a job to absolutely run at a specific time and date in the
       past, the job will run as soon as possible.  For example, if it is  8pm  and
       you do a at 6pm today, it will run more likely at 8:05pm.

       The    definition    of   the   time   specification   can   be   found   in
       /usr/share/doc/at/timespec.


