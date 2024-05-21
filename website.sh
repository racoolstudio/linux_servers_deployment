#!/bin/bash
# Setting Up website

# Website Info

WEB_URL="https://www.tooplate.com/zip-templates/2136_kool_form_pack.zip"
WEB_NAME="2136_kool_form_pack"
OS=""

# Checking for Linux Type
apt update &> /dev/null

if [ $? -gt 0 ]
then
	echo "############### THIS IS A REDHAT OS #########################"
	echo
	echo "############### INSTALLING HTTPD ############################"
	OS="RedHat"
	## Getting Httpd 
	sudo yum install unzip httpd zip net-tools  -y > /dev/null
	## Enabling Httpd
	sudo systemctl start httpd
	sudo systemctl enable httpd
else
	echo "############### THIS IS A DEBIAN OS #########################"
        echo
        echo "############### INSTALLING APACHE2 ############################"
        ## Getting (Apache Server)
	OS="Debian"
	sudo apt update
        sudo apt install unzip apache2 zip net-tools -y > /dev/null
        ## Starting Apache
        sudo systemctl start apache2
fi       

## Creating webiste directory to store the files
echo
echo "############## Creating Temporary Folders ##############"
echo 
mkdir -p /tmp/webfiles
cd /tmp/webfiles

## Downloading Website Template

echo "########### Downloading Webisite Template ###############"
echo
sudo wget $WEB_URL > /dev/null

## Upzipping

echo "################# Upzipping #######################"
echo
sudo unzip $WEB_NAME.zip > /dev/null


## Copying the file to apache/httpd service 
echo "############## COPYING UNZIPPED FILES TO HTML ###############"
sudo cp -r $WEB_NAME/* /var/www/html
echo


## Clean Up
echo "############### CLEANING UP #######################"
sudo rm -rf /tmp/webfiles
echo
echo "OS : THIS IS A $OS OS"

echo "############# Restarting Servers ##############"

if [ "$OS" = "RedHat" ]
then 
	## Restarting Service
	sudo systemctl restart httpd
else 
	sudo systemctl restart apache2
fi
## Print out the ip address
echo "########### Website Build Successful ###############"
echo 
echo "Click on the ip address starting from 172 ..."
ifconfig

