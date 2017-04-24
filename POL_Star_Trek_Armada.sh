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
EDITOR="Activision"
GAME_URL="https://en.wikipedia.org/wiki/Star_Trek:_Armada"
AUTHOR="Adam Nunez"

PATCH_13_URL="http://armadafiles.com/files/armada/mods/patches/star-trek-armada-patch-1-3-project/summary/download"
PATCH_12_URL="http://armadafiles.com/files/armada/official-releases/patches/star-trek-armada-12-patch/summary/download"
PATCH_12_NAME="armada_patch_1_2.exe"
PATCH_13_NAME="Armada_Patch_1_3_0.exe"

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

# Install
POL_Wine "$CDROM/setup.EXE"
POL_Wine_WaitExit "$TITLE"

# Ask about installing the updates
POL_SetupWindow_question "Would you like to download (or install from disk) the 1.2 (official) and 1.3 (fan-made) patches from Armadafiles.com?\n\nThese updates fix various bugs, add widescreen support, and remove the need for the disk to be insterted while playing." "$TITLE"

# Install updates
if [ "$APP_ANSWER" == "TRUE" ]; then
    POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
    if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
        POL_System_TmpCreate "$PREFIX"
        cd $POL_System_TmpDir
        #POL_Download messes up the file name here
        POL_SetupWindow_wait "Downloading..." "$Title"
        wget $PATCH_12_URL
        wget $PATCH_13_URL
        POL_Wine "$PATCH_12_NAME"
        POL_Wine_WaitExit "$TITLE"
        POL_Wine "$PATCH_13_NAME"
        POL_Wine_WaitExit "$TITLE"
        cd ~
    fi
    if [ "$INSTALL_METHOD" = "LOCAL" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the 1.2 patch file to use')" "$TITLE"
        POL_Wine "$APP_ANSWER"
        POL_Wine_WaitExit "$TITLE"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the 1.3 patch file to use')" "$TITLE"
        POL_Wine "$APP_ANSWER"
        POL_Wine_WaitExit "$TITLE"
    fi
fi

# Config
Set_Desktop "On" "1280" "1024" #Best square resolution on 1080p.
#You WILL want a window, armada will mess up your resolution otherwise

# Wrap up
POL_Shortcut "Armada.exe" "$TITLE"
POL_Wine_WaitExit "$TITLE"
POL_SetupWindow_Close
exit 0
