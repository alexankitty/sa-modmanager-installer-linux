# Sonic Adventure Mod Manager Script Installer for Linux

Before you ask, yes this is mostly recycled from the Aemulus and DMM setup scripts. This is designed to install the mod manager for you and enable one-clicks.

## Dependencies

### Steam Deck and Immutable Distros
Use the immutable script instead.  
Make sure AppImageLauncher is not installed.

### Arch
```
curl
wine
winetricks
p7zip
unzip
desktop-file-utils
lib32-gnutls
lib32-gst-plugins-base
```
Install your dependencies with the following
```
sudo pacman -S curl wine winetricks p7zip unzip desktop-file-utils lib32-gnutls lib32-gst-plugins-base
```
If wine is "missing" from the repositories, open /etc/pacman.conf in your favorite editor and uncomment the two multilib (not multililb testing lines!) close to the endo f the file.  

### Debian and similar
```
curl
wine
winetricks
p7zip
unzip
desktop-file-utils
gnutls
```

Install
```
sudo apt install curl wine winetricks p7zip unzip desktop-file-utils gnutls
```

### Fedora
```
curl
wine
winetricks
p7zip
unzip
desktop-file-utils
gnutls
gnutls.i686
```
Install
```
sudo dnf install curl wine winetricks p7zip unzip desktop-file-utils gnutls gnutls.i686
```

Make sure you have these installed before trying to run the script otherwise you will run into issues.

## Immutable Installation
Clone the repo or click code then Download zip.  
Run `./SAModManagerSetupImmutable.sh` in your terminal.  
Once completed, open your desktop's launcher and start Sonic Adventure Mod Manager.

## Installation
Make sure you have git installed if you want it super easy!  
```bash
git clone https://github.com/alexankitty/sa-modmanager-installer-linux
cd sa-modmanager-installer-linux
chmod +x ./SAModManagerSetup.sh
./SAModManagerSetup.sh
```
If wine mono pops up, you can either click install or cancel. It doesn't matter, the script will ensure it's removed later.

## Issues
Put in an issue in the repo with the output of the script and as much information as possible.

## Updating
If for some reason the URLs become out of date that the script uses for grabbing everything, you can change the download path variables under `#Download Paths`

## Uninstalling
`rm -rf ~/.local/share/samodmanager`

