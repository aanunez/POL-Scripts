#!/bin/bash
# Date : 2016-04-04
# Last revision :
# Wine version used : 2.4
# Distribution used to test : Linux Mint 18.1 x64
# Author : Adam Nunez

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Starcraft 1.18"
PREFIX="starcraft118"
WORKING_WINE_VERSION="2.5"
EDITOR="Blizzard"
GAME_URL="http://www.blizzard.com"
AUTHOR="Adam Nunez"

DOWNLOAD_URL="https://battle.net/download/getInstallerForGame?os=WIN&version=LIVE&gameProgram=STARCRAFT"
DOWNLOAD_MD5="0d7a53cc6e598ce44c1950a99a826054"
INSTALL_NAME="StarCraft-Setup.exe"

# Starting the script - do not exist yet
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Set prefix, download wine if necessary and create
POL_System_SetArch "and64"
Set_OS "win7"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Get the installer
POL_System_TmpCreate "$PREFIX"
cd $POL_System_TmpDir
POL_SetupWindow_wait "Downloading..." "$Title"
wget $DOWNLOAD_URL  #POL's download doesn't like the URL, not sure why.

# Install
POL_Wine "$INSTALL_NAME"
POL_Wine_WaitExit "$TITLE"

POL_Shortcut "StarCraft Launcher.exe" "$TITLE"
POL_Shortcut "StarEdit.exe" "StarEdit"

# Cleanup the download
POL_System_TmpDelete

POL_SetupWindow_Close
exit
