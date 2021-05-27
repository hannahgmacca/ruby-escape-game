#!/bin/bash
STR0= $'\nBefore we begin, I just need to quickly make sure all gems are installed!\n\nThis wont take long'
echo "$STR0"
bundle install
STR1= $'\nAll done, thank you for your patience.\n'
echo "$STR1"
clear
STR=$'\nYou are starting the AirBnB escape game\n\nIn order to record your score, we need your name!\n\nWhat would you like to be called?\n\n'
echo "$STR"
read username
ruby src/app/start_menu.rb $username