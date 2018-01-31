#!/bin/bash

# Crontab provision script, written by Som
set -e
set -u

_author="Som / somsubhra1 [at] xshellz.com"
_package="Crontab"
_version="1.3"

echo "Running provision for package $_package version: $_version by $_author"

if [ "$category" == "add" ]
then
 if [[ -z $cron ]]
 then
 echo "You didn't specify anything to add. Aborting!"
 exit
 fi
 #copying current crontab to tempcron
 crontab -l > tempcron

 #adding new crontab to the tempcron file
 echo "$cron" >> tempcron

 #installing new crontab
 crontab tempcron

 echo "Added $cron successfully"

 #Cleanup
 rm tempcron

elif [ "$category" == "removeall" ]
then
 #removes all crontab
 crontab -r
 echo "Removed all Cron Jobs from your shell"

elif [ "$category" == "rem" ]
then
 if [[ -z $cron ]]
 then
 echo "You didn't specify anything to remove. Please give the process name. Aborting!"
 exit
 fi
 
 #copying current cron to tempcron
 crontab -l > tempcron
 #copying other cron entries to tempcron1 except the input cron
 grep -v "$cron" tempcron > tempcron1
 #installing the tempcron1 to crontab
 crontab tempcron1

 echo "Removed $cron successfully"

 #cleanup
 rm tempcron
 rm tempcron1
 
elif [ "$category" == "list" ]
then
 echo "Your cronjob entries:"
 #copies crontab entries to tempcron
 crontab -l > tempcron
 #checks for cron entries without comment
 grep -v "#" tempcron > tempcron1
 #displays cron entries
 cat tempcron1
 
 #cleanup
 rm tempcron
 rm tempcron1
 echo "That's all"

elif [ "$category" == "help" ]
then
 echo "Type add in the category field and the command in the Cron Job field to add a Cron"
 echo "Type rem in the category field and the command in the Cron Job field to remove a Cron"
 echo "Type removeall in the category field to remove all Cron entries. (You may leave the command field blank)"
 echo "Type list in category field to list Cron entries. (You may leave the command field blank)"
 echo "Type help to show this help"
 echo "Please note that all categories are CASE SENSITIVE"
 exit

else
 echo "Wrong category. Please type help in the category field to know about the categories"
 exit
fi