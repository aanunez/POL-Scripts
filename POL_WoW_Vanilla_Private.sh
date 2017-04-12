#!/bin/bash
# Date :
# Last revision :
# Wine version used :
# Distribution used to test :
# Author :

#Notes: 100% untested

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="World of Warcraft Vanilla"
PREFIX="WorldOfWarcraftVanilla"
WORKING_WINE_VERSION="2.4"
EDITOR="Blizzard"
GAME_URL="http://www.blizzard.com"
AUTHOR="Adam Nunez"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/wow/top.jpg" "http://files.playonlinux.com/resources/setups/wow/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Wine_OverrideDLL "" "dbghelp"
POL_Wine_InstallFonts
Set_SoundDriver alsa
POL_Wine_SetVideoDriver
POL_SetupWindow_VMS

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE" --allow-kill

# Config.wtf
cd "$WINEPREFIX/drive_c"
cat << EOF > Config.wtf
SET gxApi "opengl"
SET ffxDeath "0"
SET SoundOutputSystem "1"
SET SoundBufferSize "150"
SET MasterSoundEffects "0"
EOF

# AddOn ApplyToForehead (Addon that lets you change video settings in wow on Linux)
mkdir -p "$WINEPREFIX/drive_c/$PROGRAMFILES/World of Warcraft/Interface"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/World of Warcraft/Interface"
wget "$SITE/divers/ApplyToForehead.zip"
unzip "ApplyToForehead.zip"
rm "ApplyToForehead.zip"

POL_Shortcut "WoW.exe" "$TITLE"
POL_Shortcut_InsertBeforeWine "$TITLE" "mkdir -p \"$WINEPREFIX/drive_c/$PROGRAMFILES/World of Warcraft/WTF/\""
POL_Shortcut_InsertBeforeWine "$TITLE" "cp \"$WINEPREFIX/drive_c/Config.wtf\" \"$WINEPREFIX/drive_c/$PROGRAMFILES/World of Warcraft/WTF/Config.wtf\""

POL_SetupWindow_Close


