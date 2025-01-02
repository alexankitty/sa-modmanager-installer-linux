#!/bin/sh
#Environment
WINEDLLOVERRIDES="mscoree=d;mshtml=d"
export WINEPREFIX=$HOME/.local/share/aemulus
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ICON_PATH=~/.local/share/icons/hicolor/256x256/apps/
EXEC_LINE="Exec=env WINEPREFIX=$WINEPREFIX "
EXEC_LINE+="DOTNET_ROOT= $HOME/.local/share/wine.AppImage wine "
EXEC_LINE+='C:\\\\\\\\AemulusPackageManager\\\\\\\\AemulusPackageManager.exe %u'
PATH_LINE="Path=${WINEPREFIX}/drive_c/AemulusPackageManager"
DESKTOP_PATH="$HOME/.local/share/applications"
alias wine='$HOME/.local/share/wine.AppImage wine'
alias winetricks='$HOME/.local/share/wine.AppImage winetricks'
alias wineboot='$HOME/.local/share/wine.AppImage wineboot'

#Download Paths
samm="https://github.com/X-Hax/SA-Mod-Manager/releases/latest/download/release_x64.zip"
dotnet8="https://download.visualstudio.microsoft.com/download/pr/27bcdd70-ce64-4049-ba24-2b14f9267729/d4a435e55182ce5424a7204c2cf2b3ea/windowsdesktop-runtime-8.0.11-win-x64.exe"
wineimage=$(curl -sL https://api.github.com/repos/mmtrt/WINE_AppImage/releases/tags/continuous-staging | jq -r ".assets[].browser_download_url" | grep AppImage | head -1)

curl -o $HOME/.local/share/wine.AppImage -L $wineimage
chmod +x $HOME/.local/share/wine.AppImage
wine_ver=$(wine --version)
wine_ver=${wine_ver#*-}
#setup Prefix
wineboot
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