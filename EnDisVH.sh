#!/bin/bash
####script to Enable/Disable Authontication on a virtual host
source checker.sh

#function to Enable virtual host specified by user
function EnableVhost {
	
	echo "Enter Host name like  host.com"
	read HOST
	#checker.sh
	checkVhostAvailable $HOST
	RETURN_CODE=$?
	if [ $RETURN_CODE -eq "1" ]; then
	#file exists
		checkVhostEnabled $HOST
                RETURN_CODE=$?
	        if [ $RETURN_CODE -eq "1" ]; then
	           	echo "______Virtual Host is found and Already Enabled"
			#file is not enabled
		else
		echo "________Vitual host found!!! Enabling '${HOST}'"
			 sudo a2ensite $HOST
		echo "________Restarting apache2 server"
			 sudo service apache2 reload
			 sudo service apache2 restart

			checkVhostEnabled $HOST
			RETURN_CODE=$?
			if [ $RETURN_CODE -eq "1" ]; then
		   		echo "Success!! virtual host '$HOST' is now enabled."
			else
				echo "sorry, couldnt enable '$HOST'"
			fi
		fi
	else
		   echo "_______The host '$HOST' is not found."

	fi
return 0
}


#function to Disable virtual host specified by user
function DisableVhost {
		
        echo "Enter Host name like  host.com"
        read HOST
	checkVhostAvailable $HOST
	RETURN_CODE=$?
	if [ $RETURN_CODE -eq "1" ]; then
           #file exists check if it is already disabled
		    checkVhostEnabled $HOST
        	RETURN_CODE=$?
        	#if not found inside enabled sites means it is disabled successfully
        	if [ ! $RETURN_CODE -eq "1" ]; then

			echo "_______Virtual Host Already Disabled"

		else
		        echo "________host found!! Disabling '${HOST}'"
		                 sudo a2dissite $HOST
		        echo "________Restarting apache2 server"
		                 sudo service apache2 reload
		                 sudo service apache2 restart


			checkVhostEnabled $HOST
			RETURN_CODE=$?
			#if not found inside enabled sites means it is disabled successfully
			if [ ! $RETURN_CODE -eq "1" ]; then
				 echo "Success!! virtual host '$HOST' is now disabled"
	                else
				 echo "unfortunately, couldnt disable '{$HOST}'"
			fi
		fi
        else
	 echo "The host '$HOST' is not found."

        fi

return 0
}
