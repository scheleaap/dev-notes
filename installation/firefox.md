# Firefox

Based on https://www.debugpoint.com/remove-firefox-snap-ubuntu/#Method_1_Use_PPA_Recommended

Add the following lines to `/etc/apt/preferences.d/firefox-no-snap`:
```
Package: firefox*
Pin: release o=Ubuntu*
Pin-Priority: -1
```

Run:
```sh
sudo apt purge firefox
sudo add-apt-repository ppa:mozillateam/ppa
sudo apt-get update
sudo apt install firefox
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox
```
