## Microsoft Office 2010

1. `sudo apt install playonlinux winbind ttf-mscorefonts-installer`
2. Install it though PlayOnLinux (including Gecko and wine-mono) from DVD (!)
3. If file mismatch error occurs and the file name is `WindowsXP-KB975337-x86-ENU.exe` then download the file from https://gist.github.com/AariyanApu/d28d913d20a7b85966e7460a8d2de2bb/raw/11c7fb03d63102d215d6146ea21c16e24e31dfc2/WindowsXP-KB975337-x86-ENU.exe and put it $HOME/.PlayOnLinux/ressources/
4. Version after installation 14.0.6023.1000 (32-bit) = SP1
5. Install updates based on https://askubuntu.com/a/987305
6. Delete `/home/wout/.local/share/applications/wine/Programs/Microsoft Office`
7. Delete `/home/wout/.local/share/applications/wine-extension-*`
8. Create desktop entries, register extensions and add the desktop entries to the desktop:
```sh
for f in $(ls ~/dev/dev-notes/installation/microsoft-office-2010/*.desktop); do
    ln -s $f ~/.local/share/applications/$(basename $f);
done
ln -s ~/dev/dev-notes/installation/microsoft-office-2010/wine-application-excel-2010.desktop ~/Desktop/Microsoft\ Excel\ 2010.desktop
ln -s ~/dev/dev-notes/installation/microsoft-office-2010/wine-application-word-2010.desktop ~/Desktop/Microsoft\ Word\ 2010.desktop
```
