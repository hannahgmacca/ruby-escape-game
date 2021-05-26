#!/bin/bash

STR=$'\nYou are starting the AirBnB escape game\n\nIn order to record your score, we need your name!\n\nWhat would you like to be called?\n\n'
echo "$STR"
read username

ruby src/app/start_menu.rb $username