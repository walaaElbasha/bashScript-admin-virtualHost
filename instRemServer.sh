#!/bin/bash
###script to manage installation and deletion for apache2 web server


##function to install apache2 if not already installed
function InstallApache2 {
if [ $(dpkg --get-selections | grep apache2 | wc -l ) -ne  0 ]; then
	echo "apache2 exist already!"
	dpkg --get-selections | grep apache
else
	echo "installing apache2!"
	# Install Apache
	sudo apt-get update
	sudo apt-get install apache2
	echo "Apache Installed Successfully!"
fi
}

#function to delete Apache2 if exists
function DeleteApache2 {
if [ $(dpkg --get-selections | grep apache2 | wc -l ) -ne  0 ]; then
	echo "Are you sure you want to uninstall Apache2?[y/n]"
	read CH
	case ${CH} in
	y")
	echo "Removing apache2!"
	##stopping the server
	sudo service apache2 stop
	sudo apt-get purge apache2 apache2-utils apache2.2-bin apache2-common
	sudo apt-get autoremove
	whereis apache2
	apache2: /etc/apache2
	sudo rm -rf /etc/apache2
	;;
	esac
else
	echo "Apache2 doesnt exist!!!"
fi
}
