#!/bin/bash
# Date : 2017-04-21
# Last revision : 2017-04-21
# Wine version used : 2.5
# Distribution used to test : Linux Mint 18.1 x64
# Author : Adam Nunez
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="StarWars: Battlefront II"
PREFIX="swbf2"
WORKING_WINE_VERSION="2.5"
EDITOR="Pandemic Studios"
GAME_URL="https://en.wikipedia.org/wiki/Star_Wars:_Battlefront_II"
AUTHOR="Adam Nunez"
STEAMID="6060"

# Init stuff - Images are not yet live on POL
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Installing Steam
POL_Call POL_Install_steam

# Game installation
POL_SetupWindow_message "$(eval_gettext 'Please close Steam once $TITLE has finished installing so that Play On Linux may complete the install.\n\nClick 'Next' to begin.')" "$TITLE"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine "steam.exe steam://install/$STEAMID"
POL_Shortcut "steam.exe" "$TITLE" "http://files.playonlinux.com/resources/setups/$PREFIX/$PREFIX-48x48.jpg" "steam://rungameid/$STEAMID"
POL_SetupWindow_message "Click 'Next' once $TITLE has finished downloading." "$TITLE"

# Wrap up
POL_Wine_WaitExit "$TITLE"
POL_SetupWindow_Close
exit 0
