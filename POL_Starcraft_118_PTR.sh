#!/bin/bash
# Date : 2016-04-04
# Last revision :
# Wine version used : 2.4
# Distribution used to test : Linux Mint 18.1 x64
# Author : Adam Nunez

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Starcraft 1.18 PTR"
PREFIX="Starcraft118PTR"
WORKING_WINE_VERSION="2.5"
EDITOR="Blizzard"
GAME_URL="http://www.blizzard.com"
AUTHOR="Adam Nunez"

DOWNLOAD_URL="https://d8un0y0mnd29o.cloudfront.net/public/Starcraft+1.18+PTR+1202.zip"
DOWNLOAD_MD5="e590dc85f5d140a6214496c95271b88d"
ZIP_NAME="Starcraft+1.18+PTR+1202.zip"

# Starting the script - do not exist yet
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Set prefix, download wine if necessary and create
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Get the installer
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    POL_System_TmpCreate "$PREFIX"
    cd $POL_System_TmpDir
    #POL_Download doesn't work here, not sure why (maybe https?), it doesn't even log an error
    #POL_DOWNLOAD "$DOWNLOAD_URL" "$DOWNLOAD_MD5"
    POL_SetupWindow_wait "Downloading..." "$Title"
    wget $DOWNLOAD_URL
    Install_Path="$POL_System_TmpDir/$ZIP_NAME"
    cd ~
fi
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the zip file to use')" "$TITLE"
    Install_Path="$APP_ANSWER"
fi

# Unzip/Install
POL_SetupWindow_wait "Unpacking Starcraft" "$TITLE"
check_one "unzip" "unzip"
POL_SetupWindow_missing
unzip -d ".PlayOnLinux/wineprefix/$PREFIX/drive_c" $Install_Path

POL_Shortcut "StarCraft Launcher.exe" "$TITLE"
POL_Shortcut "StarEdit.exe" "StarEdit"

# Cleanup the download
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    POL_System_TmpDelete
fi

POL_SetupWindow_Close
exit
