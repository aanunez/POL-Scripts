#!/bin/bash
# Date :
# Last revision :
# Wine version used : 2.5
# Distribution used to test : Linux Mint 18.1 x64
# Author : Adam Nunez

# Dependencies: bspatch, bsdiff, openssl

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Star Trek: Voyager – Elite Force"
PREFIX="stvef"
WORKING_WINE_VERSION="2.5"
EDITOR="Raven Software"
GAME_URL="https://en.wikipedia.org/wiki/Star_Trek:_Voyager_%E2%80%93_Elite_Force"
AUTHOR="Adam Nunez"

INSTALLED_PATH=$HOME"/.PlayOnLinux/wineprefix/"$PREFIX"/drive_c/Program Files/Raven/Star Trek Voyager Elite Force"
PATCH_STVOY="QlNESUZGNDA2AAAAAAAAAEMAAAAAAAAAAFAKAAAAAABCWmg5MUFZJlNZnBVjCQAABEpAwLAAAkAAQAAACCAAMQwIGmRiHUMhpsQvi7kinChITgqxhIBCWmg5MUFZJlNZllgeQgACV2hGwAAgAAAECAAEAEAAAAggAFCGAClRoPKkjNFJTMJCq1zbvuYlInxdyRThQkJZYHkIQlpoORdyRThQkAAAAAA="
PATCH_STVOY_HM="QlNESUZGNDA2AAAAAAAAAEcAAAAAAAAAACAOAAAAAABCWmg5MUFZJlNZu+RAkAAABFRgQClAAEAAQAAAASAAMQwIGmRiLUMhEipvi7kinChIXfIgSABCWmg5MUFZJlNZB7kv6wAC4mgLwABgAAAICABAAAIACAggAFCDJiApURptTCFTuolB75KEkzm87vNSkK/F3JFOFCQB7kv6wEJaaDkXckU4UJAAAAAA"
# Init stuff - Images are not yet live on POL
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Check disc
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "SETUP/BaseEF/pak0.pk3"

# Set prefix, download wine if necessary and create
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Config
Set_OS "winxp"

# Install
POL_Wine "$CDROM/SETUP.EXE"
POL_Wine_WaitExit "$TITLE"

# Expansion pack?
POL_SetupWindow_question "Would you like to install the Elite Force Expansion Pack? If so, you will be prompted for the CD on the next screen." "$TITLE"
if [ "$APP_ANSWER" == "TRUE" ]; then
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "Setup/baseef/pak2.pk3"
    POL_Wine "$CDROM/AUTORUN.EXE"                           #TODO Could not open String file error
    POL_Wine_WaitExit "$TITLE"

    # Apply Patch, only works for w/ Expansion
    cd "$INSTALLED_PATH"

    mv stvoy.exe stvoy_orig.exe
    echo $PATCH_STVOY > patch_64
    openssl base64 -d -in patch_64 > install_patch
    bspatch stvoy_orig.exe stvoy.exe install_patch

    mv stvoyHM.exe stvoyHM_orig.exe
    echo $PATCH_STVOY_HM > patch_64_HM
    openssl base64 -d -in patch_64_HM > install_patch_HM
    bspatch stvoyHM_orig.exe stvoyHM.exe install_patch_HM
fi

# Setup shortcut
POL_Shortcut "stvoy.exe" "$TITLE"
POL_Shortcut "stvotHM.exe" "$TITLE Holo Match"

POL_SetupWindow_Close
exit 0
