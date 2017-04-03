#!/bin/bash
# Date :
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

# Starting the script - do not exist yet
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Check disc
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "tdtwb2.mpx"

# TmpDir comes back with an extra "/" in it
POL_System_TmpDir="${POL_System_TmpDir/\/\//\/}"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Config
Set_OS "winxp"
#POL_Wine_DirectInput "DirectDrawRenderer" "gdi"

winecfg #Manually configure virtual desktop and CD Drive

# Install - Fails right now, issue copying some files
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$CDROM/SETUP.EXE" # Need to set up CD-Rom drive for this to work. :(

POL_Wine_WaitExit "$TITLE"

POL_Shortcut "tdtwb.exe" "$TITLE"

POL_SetupWindow_Close
exit 0
