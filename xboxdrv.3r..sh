#!/usr/bin/env bash

# This script is designed to be used with argos
# https://github.com/p-e-w/argos

# Ian Cleary
# https://github.com/iancleary/gnome-extensions

# Render the button based upon connection status
echo "xboxdrv | iconName=input-gaming imageWidth=20"

###################################################
############### Create Menu Options ###############
###################################################

echo "---";

echo "sudo xboxdrv --silent  | iconName=starred bash='sudo xboxdrv --silent' terminal=true"
echo "Leave the terminal open"


###################################################
############## Setup, Help ##############
###################################################

echo "---"
echo "Install the driver using:"
echo "sudo apt-get install xboxdrv | bash='sudo apt-get install xboxdrv' terminal=true"
echo "---"
echo "Blacklist the default driver"
echo "Add the line 'blacklist xpad' to the end of /etc/modprobe.d/blacklist.conf"
echo "sudo nano /etc/modprobe.d/blacklist.conf | bash='sudo nano /etc/modprobe.d/blacklist.conf' terminal=true"
echo "---"
echo "Unload the default driver"
echo "sudo rmmod xpad | bash='sudo rmmod xpad' terminal=true"
echo "---"
echo "Run xboxdrv (modified from article)"
echo "sudo xboxdrv --silent  | iconName=starred bash='sudo xboxdrv --silent' terminal=true"
echo "Leave the terminal open"

echo "---"
echo "help article (browser) | iconName=dialog-question bash='xdg-open https://support.paradoxplaza.com/hc/en-us/articles/203591147-Using-the-Xbox-360-controller-on-linux' terminal=false"
