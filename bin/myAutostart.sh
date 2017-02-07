#!/ffp/bin/sh


############################################################
### myAutostart.sh for NAS running with fun_plug
###
### Everything just taken from https://nas-tweaks.net/
### and modified/re-coded for automatization
###
### Many thanks to Uli Wolf (UW) <m@il.wolf-u.li>
###
###                           Nadz Goldman <ilya@arviol.ru> 
###
############################################################
###
###
###  DONT FORGET CHANGE PASSWORD IN VARIABLES !!!
###
############################################################

# Variable definitions
# Change it for your tasty
ROOT_PASSWORD=123456
KEEP_TELNET=1
UPDATE_SLACKER=1


# Dont touch if you dont know what is it
FFPSITES_FILE=/ffp/etc/funpkg/sites
DEBUG=0

############################################################
# changing shell and making dir for root

usermod -s /ffp/bin/sh root
mkdir -p /ffp/home/root/
sed -ie 's#:/home/root:#:/ffp/home/root:#g' /etc/passwd
pwconv
echo "root:${ROOT_PASSWORD}" | chpasswd
wget http://wolf-u.li/u/172/ -O /ffp/sbin/store-passwd.sh
chmod 777 /ffp/sbin/store-passwd.sh
/ffp/sbin/store-passwd.sh


############################################################
# enabling ssh

chmod a+x /ffp/start/sshd.sh
sh /ffp/start/sshd.sh start


if [ $KEEP_TELNET -ne 1 ]
then
	echo "Stopping telnet"
	chmod -x /ffp/start/telnetd.sh
	sh /ffp/start/telnetd.sh stop
fi

############################################################
# getting uwsiteloader with dialogs

wget http://wolf-u.li/u/441 -O /ffp/bin/uwsiteloader.sh
chmod a+x /ffp/bin/uwsiteloader.sh


############################################################
# getting sites for our architecture and updating slacker

TMPFILE1=/tmp/tmp.someFile1
TMPFILE2=/tmp/tmp.someFile2

echo "Getting sites with repo's"

wget http://wolf-u.li/u/439 -O $TMPFILE1
if [ -f /ffp/etc/ffp-version ]; then
        FFP_ARCH="$(grep FFP_ARCH /ffp/etc/ffp-version | cut -d= -f2)"
else
        echo "Unable to determine architecture from /ffp/etc/ffp-version. Are you really sure that you did the install correctly?"
        exit 1;
fi

echo "ARCH IS ${FFP_ARCH}. Grep file for this architecture"

for SITE in $TMPFILE1
do
grep  ^$FFP_ARCH $TMPFILE1 | cut -d"#" -f3,4 | sed 's/#/\t/' >> $TMPFILE2
done

echo "Making backup from ${FFPSITES_FILE} to ${FFPSITES_FILE}.old"
cp $FFPSITES_FILE $FFPSITES_FILE.old

echo "Copying repos from ${TMPFILE2} to file ${FFPSITES_FILE}"
cp $TMPFILE2 $FFPSITES_FILE

echo "Removing tmp-files: ${TMPFILE1} and ${TMPFILE2}"
rm $TMPFILE1
rm $TMPFILE2

##########################################################################################
# Checking hosts: alive or not;
# Not alive hosts kills from file with sites

for LINE in $(cat $FFPSITES_FILE | awk '{ print $2}')
	do

	# extract the protocol
	proto="`echo $LINE | grep '://' | sed -e's,^\(.*://\).*,\1,g'`"
	# remove the protocol
	url=`echo $LINE | sed -e s,$proto,,g`
	
	# extract the user and password (if any)
	userpass="`echo $url | grep @ | cut -d@ -f1`"
	pass=`echo $userpass | grep : | cut -d: -f2`
	if [ -n "$pass" ]; then
	    user=`echo $userpass | grep : | cut -d: -f1`
	else
	    user=$userpass
	fi
	
	# extract the host -- updated
	hostport=`echo $url | sed -e s,$userpass@,,g | cut -d/ -f1`
	port=`echo $hostport | grep : | cut -d: -f2`
	if [ -n "$port" ]; then
	    host=`echo $hostport | grep : | cut -d: -f1`
	else
	    host=$hostport
	fi
	
	# extract the path (if any)
	path="`echo $url | grep / | cut -d/ -f2-`"

##########################################################################################
#
# Im not sure about ports...
# I investigate hosts and find that hosts with rsync from 
# site list use not 837 port (this is rsync port), but use port 80
# So, I just take as rule: if we havent port in url, then we use port 80
#
	length=${#port}
	if [[ $length -eq 0 ]]; then
		port="80"
#		if [[ "$proto" == "http://" ]]; then
#			port="80"
#		fi
#		if [[ "$proto" == "rsync://" ]]; then
#			port="837"
#		fi
#		if [[ "$proto" == "ftp://" ]]; then
#			port="21"
#		fi
	fi


	if [[ "$DEBUG" -eq "1" ]]; then
		echo "proto = $proto"
		echo "url   = $url"
		echo "host  = $host"
		echo "pass  = $pass"
		echo "user  = $user"
		echo "port  = $port"
		echo "============================="
		echo
	fi


############################################################################################
# FUCKING SED AND BASH VARIABLES IN SED!!!!!!111
# Three hours killed for getting solution about removing hosts, which not responding!!
	
	RESULT=$(./check_port.pl -p $port -h $host | grep "BAD" | awk '{print $1}')
	length=${#RESULT}
	if [[ "$length" -ne "0" ]]; then
		sed -i "/${RESULT}/d" $FFPSITES_FILE
	fi
done


if [ $UPDATE_SLACKER -eq 1 ]
then
	echo "Running slacker update"
	/ffp/bin/slacker -U
fi


############################################################
# Last step =)

mkdir /ffp/funpkg/cache/uli/
rsync -q 'rsync://funplug.wolf-u.li/funplug/0.7/arm/packages/uwchmod-1.0-arm-1.txz' '/ffp/funpkg/cache/uli'
/ffp/bin/funpkg -i /ffp/funpkg/cache/uli/uwchmod-1.0-arm-1.txz


exit 0


