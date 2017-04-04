#!/bin/bash
# Date : 2017-03-31
# Last revision : 2017-03-31
# Wine version used : 2.4
# Distribution used to test : Linux Mint 18.1 x64
# Author : Adam Nunez
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Viscera Cleanup Detail"
PREFIX="VisceraCleanupDetail"
WORKING_WINE_VERSION="1.9.18"
EDITOR="RuneStorm"
GAME_URL="http://www.runestorm.com/viscera"
AUTHOR="Adam Nunez"
STEAMID="246900"

#DLC
TITLE_DLC="House of Horror DLC"
STEAMID_DLC="413160"

#Spin-Off Games
TITLE_SANTA="VCD: Santa's Rampage"
TITLE_SHADOW="VCD: Shadow Warrior"
PREFIX_SANTA="SantasRampage"
PREFIX_SHADOW="ShadowWarrior"
STEAMID_SANTA="265210"
STEAMID_SHADOW="255520"

# Init stuff - Images are not yet live on POL
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Ask about DLC
POL_SetupWindow_question "Would you like to install the $TITLE_DLC?\nThis DLC is not included with the original game and requires an additonal purchase.\n\nSize: 3 GB" "Install DLC?"
Install_DLC=$APP_ANSWER

# Ask about Spin-Off games
POL_SetupWindow_question "Would you like to install $TITLE_SANTA?\nThis 'Spin-off' is included with the base game and does not require an additional purchase.\n\nSize: 1.16 GB" "Install Spin-Off Games?"
Install_Santa=$APP_ANSWER
POL_SetupWindow_question "Would you like to install $TITLE_SHADOW?\nThis 'Spin-off' is included with the base game and does not require an additional purchase.\n\nSize: 1.35 GB" "Install Spin-Off Games?"
Install_Shadow=$APP_ANSWER

# Installing mandatory dependencies
POL_Wine_InstallFonts
POL_Call POL_Install_dotnet40
POL_Call POL_Install_steam

# Game installation
POL_SetupWindow_message "$(eval_gettext 'Please close Steam once $TITLE has finished installing so that Play On Linux may complete the install.\n\nClick 'Next' to begin.')" "$TITLE"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine "steam.exe" steam://install/$STEAMID
POL_Shortcut "steam.exe" "$TITLE" "http://files.playonlinux.com/resources/setups/$PREFIX/$PREFIX-48x48.jpg" "steam://rungameid/$STEAMID"
POL_SetupWindow_message "Click 'Next' once $TITLE has begun to download." "$TITLE"

# Install DLC
if [ "$Install_DLC" = "TRUE" ]
then
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
    POL_WINE "steam.exe" steam://install/$STEAMID_DLC
    POL_SetupWindow_message "Click 'Next' once $TITLE_DLC has begun to download." "$TITLE_DLC"
fi

#Install Spin-Off games
if [ "$Install_Santa" = "TRUE" ]
then
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
    POL_Wine "steam.exe" steam://install/$STEAMID_SANTA
    POL_Shortcut "steam.exe" "$TITLE_SANTA" "/http://files.playonlinux.com/resources/setups/$PREFIX/$PREFIX_SANTA-48x48.jpg" "steam://rungameid/$STEAMID_SANTA"
    POL_SetupWindow_message "Click 'Next' once $TITLE_SANTA has begun to download." "$TITLE_SANTA"
fi
if [ "$Install_Shadow" = "TRUE" ]
then
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
    POL_Wine "steam.exe" steam://install/$STEAMID_SHADOW
    POL_Shortcut "steam.exe" "$TITLE_SHADOW" "http://files.playonlinux.com/resources/setups/$PREFIX/$PREFIX_SHADOW-48x48.jpg" "steam://rungameid/$STEAMID_SHADOW"
    POL_SetupWindow_message "Click 'Next' once $TITLE_SHADOW has begun to download." "$TITLE_SHADOW"
fi

POL_Wine_WaitExit "$TITLE"

POL_SetupWindow_Close
exit 0
