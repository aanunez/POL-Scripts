#!/bin/bash
# Date : 2017-03-31
# Last revision : 2017-03-31
# Wine version used : 2.4
# Distribution used to test : Linux Mint 18.1 x64
# Author : Adam Nunez
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Viscera Cleanup Detail (Steam)"
PREFIX="VCD"
WORKING_WINE_VERSION="2.4"
EDITOR="RuneStorm"
GAME_URL="http://www.runestorm.com/viscera"
AUTHOR="Adam Nunez"
 
# Starting the script
#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Installing mandatory dependencies
POL_Call POL_Install_steam
POL_Call POL_Install_dotnet45

# Begin game installation
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine "steam.exe" steam://install/246900
POL_SetupWindow_message "$(eval_gettext 'Please close Steam once $TITLE has finished installing so that Play On Linux may complete the install.')" "$TITLE"
POL_Wine_WaitExit "$TITLE"

# Making shortcut
POL_Shortcut "foo.exe" "$TITLE"
 
POL_SetupWindow_Close
exit 0
