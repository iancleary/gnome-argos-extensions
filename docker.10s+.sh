#!/usr/bin/env bash

# This script is designed to be used with argos
# https://github.com/p-e-w/argos

# Ian Cleary
# https://github.com/iancleary/gnome-extensions

# Disclaimer: I have no affiliation with Docker, just
#             a fan of Docker (and argos!)

###################################################
############ Get Icon and Create Title ############
###################################################

HUB_URL="https://hub.docker.com/"
HUB_EXPLORE_URL="https://hub.docker.com/explore/"

HUB_USER_PROFILE_URL="https://hub.docker.com/u/iancleary/" # change to your hub
# you could create a list of users you follow, whatever!

# Local filename of ICON
ICON_NAME=Docker-R-Logo-08-2018-Monochomatic-RGB_Moby-x1.png

#URL of icon to if no local file exists
ICON_URL="https://www.docker.com/sites/default/files/d8/Docker-R-Logo-08-2018-Monochomatic-RGB_Moby-x1.png"


# Download favicon to use in title
if [ -f $ICON_NAME ]; then
	# if favicon exists, use it as icon
	DOCKER_ICON=$(base64 -w 0 $ICON_NAME)
else
	# doesn't exist download ICON from nordvpn via ICON_URL
	DOCKER_ICON=$(curl -s $ICON_URL | base64 -w 0)
fi

echo "Docker | image='$DOCKER_ICON' imageWidth=20"


dockerd_status="$(systemctl show --property ActiveState docker)"

# ActiveState=active is the output of dockerd_status, parse string to get "active"
connected_status=${dockerd_status:12:6}
# echo "${connected_status}" -> "active" or "inactive"

echo "---";

# Change menu by connection status
if [ "$connected_status" == "active" ]; then
	docker_version_output="$(docker --version)"
	docker_images_output="$(docker container ls)"
	docker_container_ls_output="$(docker container ls)"

	###################################################
	############### Create Menu Options ###############
	###################################################

	echo "---";
	echo "Images"
	echo "${docker_images_output}"
	echo "---";
	echo "Containers"
	echo "${docker_container_ls_output}"
	###################################################
	############## Status, Version, Help ##############
	###################################################

	# Display version
	echo "---";
	echo "${docker_version_output}"

	dockerd_pid="$(pidof dockerd)"
	echo "---";
	# echo "${dockerd_pid}"
	echo "stop dockerd (terminal for sudo) | iconName=process-stop bash='sudo kill ${dockerd_pid}' terminal=True"

else
	#echo "NordVPN Off | image='$NORDVPN_ICON' imageWidth=20"
	echo "Dockerd is not running."
	echo "---"

	echo "start docker (silent)  | iconName=dialog-question bash='docker' terminal=false"
	echo "start docker (terminal)  | iconName=dialog-question bash='docker' terminal=True"
fi


###################################################
############# Settings (if connected) #############
###################################################

echo "---"
echo "My Docker Hub Account | iconName=avatar-default href='$HUB_USER_PROFILE_URL'"
