#!/bin/sh
#Environment
WINEDLLOVERRIDES="mscoree=d;mshtml=d"
export WINEPREFIX=$HOME/.local/share/samodmanager
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ICON_PATH=~/.local/share/icons/hicolor/256x256/apps/
EXEC_LINE="Exec=env WINEPREFIX=$WINEPREFIX "
EXEC_LINE+='DOTNET_ROOT="" wine '
EXEC_LINE+='C:\\\\\\\\SAModManager\\\\\\\\SAModManager.exe %u'
PATH_LINE="Path=${WINEPREFIX}/drive_c/SAModManager"
DESKTOP_PATH="$HOME/.local/share/applications"
wine_ver=$(wine --version)
wine_ver=${wine_ver#*-}

#Download Paths
samm="https://github.com/X-Hax/SA-Mod-Manager/releases/latest/download/release_x64.zip"
dotnet8="https://download.visualstudio.microsoft.com/download/pr/27bcdd70-ce64-4049-ba24-2b14f9267729/d4a435e55182ce5424a7204c2cf2b3ea/windowsdesktop-runtime-8.0.11-win-x64.exe"

if [[ $wine_ver < 8.20 ]]
then
    echo "Wine version is unsupported, please upgrade to wine version 8.26 or later. You may need to install wine-staging package."
    exit
fi

#setup Prefix
mkdir $WINEPREFIX
wineboot -u
#cd ${WINEPREFIX}/drive_c/windows/Fonts && for i in /usr/share/fonts/**/*.{ttf,otf}; do ln -s "$i"; done
cd $SCRIPT_DIR
curl -o /tmp/windowsdesktop-runtime-8.0.11-win-x64.exe $dotnet8
if [[ $wine_ver < 9.0 ]]
then
    winetricks -q dotnet48
    winetricks -q dotnet35
    winetricks -q win10
fi
wine /tmp/windowsdesktop-runtime-8.0.11-win-x64.exe /passive
rm /tmp/windowsdesktop-runtime-8.0.11-win-x64.exe
curl -Lso /tmp/samm.zip $samm
unzip /tmp/samm.zip -d "${WINEPREFIX}/drive_c/SAModManager"
rm /tmp/samm.zip

winetricks -q win11

#Setup desktop icon
cp $SCRIPT_DIR/SAModManager.png $ICON_PATH/SAModManager.png
sed -i "s|^Exec=.*|$EXEC_LINE|" $SCRIPT_DIR/SAModManager.desktop
sed -i "s|^Path=.*|$PATH_LINE|" $SCRIPT_DIR/SAModManager.desktop

desktop-file-install --dir=$DESKTOP_PATH $SCRIPT_DIR/SAModManager.desktop
update-desktop-database $DESKTOP_PATH
