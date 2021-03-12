#!/usr/bin/bash

#function to check if a specific Vhost is an available site or not
function checkVhostAvailable {
HOST=${1}
PATH_AVAIL="/etc/apache2/sites-available"
if [ -f $PATH_AVAIL/$HOST.conf ]; then
	#vhsot available
   return 1;
else
	#vhost is not available
   return 2;
fi
return 0

}

#a function to check if a specific Vhost is enabled or not
function checkVhostEnabled {
HOST=${1}
PATH_EN="/etc/apache2/sites-enabled"
if [ -f  $PATH_EN/$HOST.conf ]; then
	#vhost is enabled
   return 1;
else
	checkVhostAvailable $HOST
	RET=$?
		if [ $RET -q 1 ]; then
		#vhost is disabled
		return 2
		else
		#vhost doesnot exists
		return 3
		fi	
fi
return 0
}

#function to check if the login user is a root or having root privileges or not
function check_root {
if [ "$(whoami)" != "root" ]; then
    echo "Root privileges are required to run this, try running with sudo..."
exit 0;    
fi
}


##function to check if configration file name is duplicate 
function checkValidaton {
confg=${1}   
if [ ! -f "/etc/apache2/sites-available/$confg.conf" ]; then 
	touch "/etc/apache2/sites-available/$confg.conf"
	echo "Config file successfully created !"
	return 1
else
	echo "Sorry, Duplicate name couldnt create config file !"
	echo "try sudo nano /etc/apache2/sites-available/hostname.com.conf"
	return 2
fi
}
