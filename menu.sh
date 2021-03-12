#!/bin/bash
source checker.sh

source AddRemoveVH.sh

source EnDisAuth.sh

source EnDisVH.sh

source instRemServer.sh

### Function to display menu
function displayMenu {
	check_root
	echo "Main menu"
	echo "-------------------------------------------------"
	echo "1-Install Apache2 Web Server"
	echo "2-Remove Apache2 Web Server"
	echo "3-Display All Available/Enabled virtual hosts"
	echo "4-Add a new virtual host"
	echo "5-Remove a virtual host"
	echo "6-Enable a virtual host"
	echo "7-Disable a virtual host"
	echo "8-Enable authontication for a Vhost"
	echo "9-Disable authontication for a Vhost"
	echo "10-Quit"
}

##Function to display all virtual hosts
function displayVhost {
	echo "__________________________________________"
	echo "__________Available virtual hosts_________"
	ls -l /etc/apache2/sites-available/
	echo "__________________________________________"
	echo "__________Enabled virtual hosts___________"
	ls -l /etc/apache2/sites-enabled/
return 0
}

###Function to control menu operations
function runMenu {
	local CH
	echo "Enter your choice"
	local FLAG=1
	while [ ${FLAG} -eq 1 ]
	do
	read CH
	case ${CH} in
		"1")
			InstallApache2
			;;
		"2")	
			DeleteApache2
			;;
		"3")
			displayVhost
			;;
		"4")
			#AddRemoveVH.sh
			AddVhost
			;;
		"5")
			#AddRemoveVH.sh
			RemoveVhost
			;;
		"6")
			#EnDisVH.sh
			EnableVhost
			;;
		"7")
			#EnDisVH.sh
			DisableVhost
			;;
		"8")
			#EnDisAuth.sh
			EnableAuth
			;;
		"9")
			#EnDisAuth.sh
			DisableAuth
			;;
		"10")
			FLAG=0
			;;
		*)
			echo "Invalid choice, please try again"
			;;
	esac
	if [ ${FLAG} -eq 1 ]
	then
		displayMenu
	fi
	done
}

