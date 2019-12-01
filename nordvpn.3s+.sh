#!/usr/bin/env bash

# This script is designed to be used with argos
# https://github.com/p-e-w/argos

# Ian Cleary
# https://github.com/iancleary/gnome-extensions

# Disclaimer: I have no affiliation with NordVPN, just
#             a fan of Gnome and NordVPN (and argos!)

# If you are looking to modify anything, feel free
# For simple configuration, I recommend the country list

###################################################
############### Starred Countries #################
###################################################

# Edit this list with country codes or country names
# Use 'nordvpn countries' to show the country list
# Country codes are 2 letter abbreviations
# (https://www.nationsonline.org/oneworld/country_code_list.htm)

declare -a COUNTRY_LIST=("us" "fr" "nl")
# declare -a COUNTRY_LIST=("United_States" "France" "Netherlands")

###################################################
############ Get Icon and Create Title ############
###################################################

DASHBOARD_URL="https://ucp.nordvpn.com/dashboard"

# Local filename of ICON
ICON_NAME=favicon-96x96.png

#URL of icon to if no local file exists
ICON_URL="https://s1.nordcdn.com/nordvpn/media/0.54.0/images/global/favicon/favicon-96x96.png"


# Download favicon to use in title
if [ -f $ICON_NAME ]; then
	# if favicon exists, use it as icon
	NORDVPN_ICON=$(base64 -w 0 $ICON_NAME)
else
	# doesn't exist download ICON from nordvpn via ICON_URL
	NORDVPN_ICON=$(curl -s $ICON_URL | base64 -w 0)
fi


# Get connection status and save output
NordVPN_status_output="$(nordvpn status)"

# Extract string from output to get connection status
# This relies on the first line of the output of
# "nordvpn status" being "You are connected to NordVPN."
connected_status=${NordVPN_status_output:8:9}

# Render the button based upon connection status
# I opted for the icon and no image; up to you
if [ "$connected_status" == "Connected" ]; then
	#echo "NordVPN On| image='$NORDVPN_ICON' iconName=security-high imageWidth=20"
	echo "NordVPN | image='$NORDVPN_ICON' iconName=security-high imageWidth=20"
else
	#echo "NordVPN Off | image='$NORDVPN_ICON' imageWidth=20"
	echo "NordVPN | image='$NORDVPN_ICON' iconName=security-low imageWidth=20"
fi

###################################################
############### Create Menu Options ###############
###################################################

echo "---";

# Starred countries you prefer to connect to
for country in "${COUNTRY_LIST[@]}"; do
	current_country=$country
	echo "nordvpn connect $current_country | iconName=starred bash='nordvpn disconnect && nordvpn connect $current_country' terminal=false"
done

# disconnect, login, logout
# for disconnect's icon, I went back and forth between security-low and process-stop
echo "nordvpn disconnect  | iconName=security-low bash='nordvpn disconnect' terminal=false"
echo "nordvpn login (terminal) | iconName=dialog-password bash='nordvpn login' terminal=true"
echo "nordvpn logout (terminal) | iconName=dialog-password bash='nordvpn logout' terminal=true"
# End Menu Section

###################################################
############## Status, Version, Help ##############
###################################################

echo "---"
echo "${NordVPN_status_output}"

# Display nordvpn version
NordVPN_version_output="$(nordvpn -v)"
echo "---"
echo "${NordVPN_version_output} | iconName=dialog-information"
echo "nordvpn help (terminal) | iconName=dialog-question bash='nordvpn help' terminal=true"

###################################################
############# Settings (if connected) #############
###################################################

# If connected, add settings section
if [ "$connected_status" == "connected" ]; then
	NordVPN_settings_output="$(nordvpn settings)"
	echo "---"
	echo "${NordVPN_settings_output}"
fi

###################################################
############ Link to Account Dashboard ############
###################################################

echo "---"
echo "My NordVPN Account | iconName=avatar-default href='$DASHBOARD_URL'"
