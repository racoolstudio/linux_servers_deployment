#!/bin/bash

## Go through the servers:

USER="devops"
FILE="/home/$USER/website.sh"
for web in `cat server`
do 
	#### Connecting to Servers ######
	echo 
	echo "############ Connecting To $web Server ##################"
	echo
	echo "############### Copying File To $web #####################"
	
	ssh $USER@$web rm /home/$USER/website.sh &> /dev/null
	
	scp website.sh $USER@$web:/home/$USER &> /dev/null

	echo "############# Setting Up Execution Permission ##################"
	echo 
	ssh $USER@$web chmod +x -R /home/$USER
	
	echo "################## Runnig Script ######################"

	ssh $USER@$web sh /home/$USER/website.sh
	
	echo "##### Cleaning Up ########"

        ssh $USER@$web rm /home/$USER/website.sh &> /dev/null	

done
