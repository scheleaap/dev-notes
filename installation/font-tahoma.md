# Tahoma font

Source: https://askubuntu.com/a/733405

```sh
#!/bin/bash
[ ! -f /usr/share/fonts/truetype/msttcorefonts/tahoma.ttf -o ! -f /usr/share/fonts/truetype/msttcorefonts/tahomabd.ttf ] &&
wget https://sourceforge.net/projects/corefonts/files/OldFiles/IELPKTH.CAB &&
cabextract -F 'tahoma*ttf' IELPKTH.CAB &&
sudo mkdir -p /usr/share/fonts/truetype/msttcorefonts/ &&
sudo mv -f tahoma*ttf /usr/share/fonts/truetype/msttcorefonts/ &&
sudo chmod 644 /usr/share/fonts/truetype/msttcorefonts/tahoma* &&
fc-cache -v &&
rm -f IELPKTH.CAB &&
echo "Installed Tahoma"
```
