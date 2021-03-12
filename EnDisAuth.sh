#!/bin/bash
####script to Enable/Disable Authontication on a virtual host
source checker.sh

#function to enable authontication for a specific virtual host
 function EnableAuth {
	 PATH_AVAIL="/etc/apache2/sites-available"
	 echo "type Name of Virtual Host to enable auth for -like host.com"
	 read VHOST
	 
	 checkVhostAvailable $VHOST
	 RETURN_CODE=$?
	 if [ $RETURN_CODE -eq "1" ]; then
		 echo "___VHost found!!"
		 echo "___Document Root Found!! "
		 grep -i 'DocumentRoot' $PATH_AVAIL/$VHOST.conf
		 echo "enter ABOVE path of DocumentRoot to continue"
                 read DOC
		 if [ -d "$DOC" ]; then
		 
			if [ -f $DOC/.htaccess ]; then
				echo "!!Authontication is already enabled"
			else
				sudo touch $DOC/.htaccess
				echo "type title for your private area.. "
				read AUTH_NAME
				sudo chmod u+rwx $DOC/.htaccess
				echo "
					AuthType Basic
					AuthName $AUTH_NAME
					AuthUserFile /etc/apache2/.htpasswd
					Require valid-user
					" > $DOC/.htaccess
				echo "_____Authontication is now enabled for Valid Users"
			 fi
			 echo "want to add a user account? [y/n]"
			 read CH
			 case ${CH} in
			 "y")
				echo "write username"
				read USERNAME
				if [ -f /etc/apache2/.htpasswd ]; then
  					sudo htpasswd /etc/apache2/.htpasswd $USERNAME
				else
				 	sudo htpasswd -c /etc/apache2/.htpasswd $USERNAME
				fi
				echo "___User added Successfully"
			 ;;
			 esac

		 else
			 echo "No matching directory found!!!!"
		 fi

	 else
		 echo "this Virtual host doesnt exist"
	 fi

 return 0
}

#function to disable authontication for a specific virtual host
function DisableAuth {

         PATH_AVAIL="/etc/apache2/sites-available"
         echo "type Name of Virtual Host to Disable auth for -like host.com"
         read VHOST
         checkVhostAvailable $VHOST
         RETURN_CODE=$?
         if [ $RETURN_CODE -eq "1" ]; then
                 echo "___VHost found!!"
                 echo "___Document Root Found!! "
                 grep -i 'DocumentRoot' $PATH_AVAIL/$VHOST.conf
                 echo "enter ABOVE path of DocumentRoot to continue"
                 read DOC
                 if [ -d $DOC ]; then
			if [ -f $DOC/.htaccess ]; then
				echo "Disabling Authontication for your site"
				rm $DOC/.htaccess
				if [ -f /etc/apache2/.htpasswd ]; then 
	      	       			echo "Do you want to delete valid users list?[y/n]"
			  		read CH
			  		case ${CH} in
	                       		"y")

					sudo rm /etc/apache2/.htpasswd

					;;
	  		  		esac
				fi
				echo "Success!! now ${VHOST} is disabled"
			else
				echo "Authontication for this virtual host is already disabled"

			fi
	         else
                 	     echo "No matching directory found!!!!"
                 fi

         else
                 echo "this Virtual host doesnt exist"
         fi
return 0
}
