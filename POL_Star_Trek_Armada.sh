#!/bin/bash
# Date : 2017-04-22
# Last revision :
# Wine version used : 2.5
# Distribution used to test : Linux Mint 18.1 x64
# Author : Adam Nunez
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Star Trek: Armada"
PREFIX="starmada"
WORKING_WINE_VERSION="2.5"
EDITOR="Raven Software"
GAME_URL=""
AUTHOR="Adam Nunez"

# Init stuff - Images are not yet live on POL
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Check disc
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup/animations/STIntro.bik"

# Set prefix, download wine if necessary and create
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Config
Set_OS "winxp"
Set_Desktop "On" "1280" "1024" #Best square resolution on 1080p.
#You WILL want a window, armada will mess up your resolution otherwise

# Install
POL_Wine "$CDROM/setup.EXE"
POL_Wine_WaitExit "$TITLE"

# Setup shortcut
POL_Shortcut "Armada.exe" "$TITLE"

POL_SetupWindow_Close
exit 0
