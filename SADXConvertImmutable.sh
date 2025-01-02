export WINEPREFIX=$HOME/.local/share/samodmanager
alias wine='$HOME/.local/share/wine.AppImage wine'
alias winetricks='$HOME/.local/share/wine.AppImage winetricks'
alias wineboot='$HOME/.local/share/wine.AppImage wineboot'

#Download Paths
sdaxmi="https://dcmods.unreliable.network/owncloud/data/PiKeyAr/files/Setup/sadx_setup.exe"
curl -Lso /tmp/sadx_setup.exe $sdaxmi
cp /tmp/sadx_setup.exe "${WINEPREFIX}/drive_c/SAModManager"

#Launch
wine "${WINEPREFIX}/drive_c/SAModManager/sadx_setup.exe"