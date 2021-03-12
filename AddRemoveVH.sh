#!/bin/bash
#script to add/remove a virtual host
source checker.sh


#function to add a new host
function AddVhost {

read -p "Enter DocumentRoot Path -like /var/Dir_name/host.com___" DIR
	if [ -d "$DIR" ]; then
		echo "Sorry,Duplicate name try Again"
		
	else
		mkdir -p $DIR
		read -p "Enter the server name you want: " SERV
		checkVhostAvailable $SERV
		RETURN=$?
		if [ $RETURN -eq 1 ]; then
			echo "Sorry, Duplicate Server Name try again  "
			sudo rm -r DIR
		else
		read -p "enter the html name: " HTM_FILE
		createHTML $DIR $HTM_FILE
		
		#checker.sh
		checkValidaton $SERV
		RET=$?
			if [ $RET -eq 1 ]; then
				
				create_vh $DIR $SERV
			fi
		fi	
	fi		
return 0
}

#function that creates HTML file for a new vh host
function  createHTML {
dir=${1}
file=${2}

	touch "$dir/$file.html"
	sudo chmod u+wx $dir/$file.html
	echo "<html><head></head><body>Welcome!</body></html>" > $dir/$file.html
	echo "HTML file created with success !"
	echo "Full Path: $dir/$file.html"

}

##function to create vh and check if it created or not 
function  create_vh  {
dir=${1}
servn=${2}
if [  -f "/etc/apache2/sites-available/$servn.conf" ]; then

echo "
<VirtualHost *:80>
	ServerName $servn
	DocumentRoot $dir
</VirtualHost>
<Directory $dir> 
	AllowOverride All 
</Directory> 
" > /etc/apache2/sites-available/$servn.conf
echo "Configuration file created in path.."          
echo -e /etc/apache2/sites-available/$servn.conf
echo "success!!!! Virtual host created !"
else
echo "file didn't exist...please enter a valid file "
fi 

}


#function to remove a virtual host specified by user
function RemoveVhost {

	 PATH_AVAIL="/etc/apache2/sites-available"
	 echo "Enter Virtual Host name -like host.com- that you want to remove"
	 read HOST
	 sudo -v
	 echo "Removing $HOST from /etc/hosts."
	 sudo sed -i '/'$HOST'/d' /etc/hosts
	 echo "Disabling and deleting the $HOST virtual host."
	 sudo a2dissite $HOST
	 ret=$?
	 if [ $ret -eq 0 ]; then
		 echo "_________Document root for $HOST is________"
		 grep -i 'DocumentRoot' $PATH_AVAIL/$HOST.conf

		 echo "do you want to remove document root with all its content [y/n]?"
		 read CH
		 case ${CH} in
			 "y")
		 echo "_________Document root for $HOST is________"
		 grep -i 'DocumentRoot' $PATH_AVAIL/$HOST.conf
		 echo "write the ABOVE document root directory path to continue"
		 read DOC_ROOT
		 sudo rm -r $DOC_ROOT
		 echo "OK! document root is removed"
			 ;;
			 "n")
		 echo "OK! document root still exists"
		 esac
      		 sudo rm $PATH_AVAIL/$HOST.conf
		 sudo service apache2 reload
		 echo "SUCESS!!! virtual host has been removed"
	 else
		 echo "_______operation failed"
	 fi

 return 0
 }

