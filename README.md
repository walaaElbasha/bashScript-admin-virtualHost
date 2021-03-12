# bashScript-admin-virtualHost
This project is to 
	-manage installation and deletion of apache2 web server
	-Add,Delete,Enable,Disable Virtual Host
	-Enable And disable authntication for a virtual host

1-run 
run ./main.sh to display menu and choose the operation you want

2-files 

main.sh
________
	it is the entry to the project 
	it calls functions that displays menu

menu.sh
_________
	function displayMenu
	     -displays menu options
	     1-Install Apache2 Web Server
	     2-Remove Apache2 Web Server
	     3-Display All Available/Enabled virtual hosts
	     4-Add a new virtual host
	     5-Remove a virtual host
	     6-Enable a virtual host
	     7-Disable a virtual host
	     8-Enable authontication for a Vhost
	     9-Disable authontication for a Vhost
	     10-Quit
	function runMenu
	     -controls menu operations
	     -at every menu option it calls a function that exists in other scripts
	function displayVhost 
	     -display all available and enabled virtual hosts	


instRemServer.sh 
________________
	function InstallApache2 
		it installs apache2 web server only if not already installed
	function DeleteApache2
		it uninstalls apache2 only if exists 
	

AddRemoveVH.sh
_________________
	this script has function that manages Adding and Removing a virtual host
	function AddVhost 
		this function adds a new virtual host
		it asks the user to enter DocumentRoot for his virtual host and checks if it is a valid or a duplicate entry 
		also asks the user to enter server name and checks if it is a valid entry or a duplicate
		asks the user for html file name using function  createHTML
		it then creates the virtual host configuration file inside /etc/apache2/sites-available using create_vh
		and creates HTML file inside the DocumentRoot 
	function RemoveVhost
		this function removes a virtual host
		it asks the user for Vhost name, if it is found inside sites available, it will be disabled and its configuration file will be deleted, apache2 restarts
		the user is then asked if he wants to delete documentRoot or leave it
		and acts accordingly

EnDisVH.sh
__________
	this script manages enabling and disabling a virtual host
		function EnableVhost
			the user is asked to enter a vhost name 
			if it exists insides sites-avaliable and is enabled, it will be disabled, otherwise will tell user wrong entry if not available or it is already enabled in case it was already enabled
		function DisableVhost
			the user is asked to enter a vhost name 
			if it exists insides sites-available and doesnt exists inside enabled sites, it will be disabled, other wise will tell the user wrong entry if not available, or already disabled in case it was already disabled

EnDisAuth.sh
____________
	this script manages enabling and disabling authontication for a virtual host
	function EnableAuth
		asks the user to enter vhost name and if it is found,it checks if it already has authontication or not, if not a .htaccess file is created that has authontication for valid users inside document root.
		also assk the user if he wants to add  a user account 
		if so a .htpasswd file is created inside /etc/apache2/.htpasswd is created with emails and passwords 
	
	function DisableAuth
		asks the user to enter vhost name and if it is found,it checks if it has a .htaccess file (was authonticated) if so , it deletes that file and asks the user if he wants to delete valid users accodingly .htpasswd file will be deleted

checker.sh
_________
	function checkVhostAvailable
		this function recieves a host name and checks if it is included inside /etc/apache2/sites-available , if so means it is available and returns 1,other wise returns 2
	function checkVhostEnabled
	this function recieves a host name and checks if it is available first if so, checks if it is included inside /etc/apache2/sites-enabled , if so means it is enabled returns 1,other wise returns 2 means disabled, returns  3 if it is not an availbale host
	function checkValidaton
		this function checks for the validation of a config file, it recieves a name for the config file and searches for it inside the available sites , if it is not duplicate it touches it and returns 1 else it returns 2 which means it is duplicate.
		
