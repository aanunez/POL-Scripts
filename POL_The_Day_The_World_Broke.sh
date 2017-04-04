#!/bin/bash
# Date : 2016-04-03
# Last revision :
# Wine version used : 2.4
# Distribution used to test : Linux Mint 18.1 x64
# Author : Adam Nunez
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="The Day The World Broke"
PREFIX="tdtwb"
WORKING_WINE_VERSION="2.4"
EDITOR="Houghton Mifflin Interactive - David Wiesner"
GAME_URL="http://www.houghtonmifflinbooks.com/authors/wiesner/books/books_day.shtml"
AUTHOR="Adam Nunez"

# Init stuff - Images are not yet live on POL
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Check disc
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "tdtwb2.mpx"

# Set prefix, download wine if necessary and create
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Config
Set_OS "winxp"
POL_Wine_DirectInput "Desktops" "1024x768"

# Install
POL_Wine "$CDROM/SETUP.EXE"
POL_Wine_WaitExit "$TITLE"

POL_Shortcut "tdtwb.exe" "$TITLE" #Error, disc missing :\

POL_SetupWindow_Close
exit 0
