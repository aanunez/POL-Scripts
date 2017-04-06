#!/bin/bash
# Date : 2016-04-02
# Last revision :
# Wine version used : 2.4
# Distribution used to test : Linux Mint 18.1 x64
# Author : Adam Nunez
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Titanic: Adventure Out of Time"
PREFIX="titanic"
WORKING_WINE_VERSION="2.4"
EDITOR="Cyberflix"
GAME_URL="https://en.wikipedia.org/wiki/Titanic:_Adventure_Out_of_Time"
AUTHOR="Adam Nunez"

INSTALLED_PATH=".PlayOnLinux/wineprefix/"$PREFIX"/drive_c/Program Files/CyberFlix/Titanic"
TITANIC_PATCH="QlNESUZGNDAxAAAAAAAAAD4AAAAAAAAAAAwHAAAAAABCWmg5MUFZJlNZuX4LeAAABEBCSKRAAAICIAAxDAgjEYhSwM2IS+LuSKcKEhcvwW8AQlpoOTFBWSZTWXyf23oAAzFiiMAAAAQBAAEAEAAACCAAMMAClKH6pkKLcFN6VRJu3UQr8XckU4UJB8n9t6BCWmg5F3JFOFCQAAAAAA=="

# Init stuff - Images are not yet live on POL
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# We need a few programs
POL_SetupWindow_message "Due to the age of this game it must be run in 256 color mode.\nTo do this without changing the color mode of your native display a virtual monitor will be created using Xephyr. Please insure Xephyr is installed (package: xserver-xephyr) before proceeding." "$TITLE"
check_one "Xephyr" "xserver-xephyr"
POL_SetupWindow_missing
check_one "bspatch" "bsdiff"
POL_SetupWindow_missing

# Ask about number of monitors
POL_SetupWindow_textbox "Xephyr will be used to create a virtual monitor, how many monitors do you have currently?" "$TITLE" "1"
MONITOR_NUMBER=$APP_ANSWER
# TODO Check if number

# Check disc
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "DATA/BEDRAD1.TRK"
#TODO Ask if CD mounted correctly?
#sudo apt install gddrescue
#sudo ddrescue -d -b 2048 /dev/loop2p1 TITANIC1.iso Titanic.log
#sudo ddrescue -d -b 2048 /dev/loop1p1 TITANIC2.iso Titanic.log

# Set prefix, download wine if necessary and create
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Config
Set_OS "winxp"
POL_Wine_DirectInput "DirectDrawRenderer" "gdi"
#Set_Desktop "On" "640" "480"

# Install
POL_Wine "$CDROM/SETUP.EXE"
POL_Wine_WaitExit "$TITLE"

# Copy over files
POL_SetupWindow_wait "Copying Data Files..." "$Title"
cp -R $CDROM/* "$INSTALLED_PATH" #TODO cp not working
POL_SetupWindow_message "$(eval_gettext 'Please insert disc 2 into your disk drive if not already done.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "data/a14.set"
POL_SetupWindow_wait "Copying Data Files..." "$Title"
cp -rf $CDROM/* "$INSTALLED_PATH" #TODO cp not working

# Apply Patch
cd "$INSTALLED_PATH"
mv ti.exe ti_orig.exe
openssl base64 -d $TITANIC_PATCH > ti_patch
bspatch ti_orig.exe ti.exe ti_patch

# Setup shortcut to run in Xephyr
POL_Shortcut "ti.exe" "$TITLE"
POL_Shortcut_InsertBeforeWine "$TITLE" "Xephyr :1 -ac -screen 640x480x16 & DISPLAY=:1 \\"

POL_SetupWindow_Close
exit 0
