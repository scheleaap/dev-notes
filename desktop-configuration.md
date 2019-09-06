# Eigen configuatie

Things to add to Ansible:
* Install Spotify: https://linuxconfig.org/how-to-install-spotify-on-ubuntu-18-04-bionic-beaver-linux#h6-1-install-from-ubuntu-software
* sudo apt install gnome-tweak-tool


## Software installation

## SSH Key

```
ssh-keygen -t rsa -b 4096 -C "wout-$(date '+%Y%m%d')-rsa4096"
```

## Chromedriver

```bash
CHROME_DRIVER_VERSION=76.0.3809.68
wget -N http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip -P /tmp
unzip /tmp/chromedriver_linux64.zip -d /tmp
rm /tmp/chromedriver_linux64.zip
sudo mv -f /tmp/chromedriver /usr/local/bin/chromedriver
sudo chown root:root /usr/local/bin/chromedriver
sudo chmod 0755 /usr/local/bin/chromedriver
```

## Commitizen

https://commitizen.github.io/cz-cli/


### Emoji Picker

```
sudo add-apt-repository ppa:ys/emojione-picker
sudo apt-get update
sudo apt-get install emojione-picker
```

## Linuxbrew (Homebrew)
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
sudo apt-get install build-essential
echo 'eval $(/home/wout/.linuxbrew/bin/brew shellenv)' >>~/.zlogin
eval $(/home/wout/.linuxbrew/bin/brew shellenv)
brew install gcc
```

TODO: PATH=/home/wout/.linuxbrew/Homebrew/Library/Homebrew/vendor/portable-ruby/current/bin:$PATH


## Ubuntu Tweak

```
wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu xenial-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'
sudo apt-get update
sudo apt-get install ubuntu-tweak
```

## Vagrant

```
sudo bash -c 'echo deb https://vagrant-deb.linestarve.com/ any main > /etc/apt/sources.list.d/wolfgang42-vagrant.list'
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key AD319E0F7CFFA38B4D9F6E55CE3F3DE92099F7A4
sudo apt-get update
sudo apt-get install vagrant
```

## Virtualbox

```bash
sudo apt install virtualbox
```

https://stegard.net/2016/10/virtualbox-secure-boot-ubuntu-fail/


## Linux

### sudo

Toegevoegd aan `/etc/sudoers`:
```
wout ALL = (root) NOPASSWD: /usr/sbin/service mysql start
wout ALL = (root) NOPASSWD: /usr/sbin/service mysql stop
```

### Netwerk

https://bugs.launchpad.net/ubuntu/+source/systemd/+bug/1624320/comments/8

* Indien nodig: (VEROUDERD?)
  ```
  rm -rf /etc/resolv.conf
  ln -s /run/resolvconf/resolv.conf /etc/resolv.conf
  ```
* Indien nodig: (vanaf Ubuntu 17.10)
  ```
  rm -rf /etc/resolv.conf
  ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
  ```
* Toevoegen aan `/etc/network/interfaces`:
  ```
  auto eth0
  iface eth0 inet dhcp
    dns-search rz01.deposit-solutions.com
    ```

### SSHFS

```sh
sudo apt-get install sshfs
sudo gpasswd -a $USER fuse
```

Mounten:
```sh
mkdir ~/remote_projects
sshfs -o idmap=user user@host:/path ~/remote_projects
```

Unmounten:
```sh
fusermount -u ~/remote_projects
```

## Java

Oracle JDK:
```
sudo apt-add-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
```


## Nativefier

```sh
docker run -v ~/bin:/target jiahaog/nativefier "https://web.whatsapp.com/" /target/ --single-instance --name "WhatsApp"
docker run -v ~/bin:/target jiahaog/nativefier "https://www.mixcloud.com/" /target/ --single-instance --name "Mixcloud"
docker run -v ~/bin:/target jiahaog/nativefier "https://teams.microsoft.com/" /target/ --single-instance --name "Teams"
(~/bin/teams-linux-x64/teams 2>&1 /dev/null &)

```


## Thunderbird

Toegevoegd aan configuatie:
```
// Recognition of localized reply indicators
user_pref("mailnews.localizedRe", "AW,Aw,ANTW,Antwort");
```


## GNOME config
* You can also use `dconf-editor` to change GNOME settings yourself.
* Alt-Tab
  * Goal:
    * Move the value '<Alt>Tab' from switch-applications to switch-windows
    * Move '<Shift><Alt>Tab' from switch-applications-backward to switch-windows-backward
  * Run:
    ```bash
    gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
    gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"
    gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"
    gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>Tab']"
    ```
* Disable Alt+F7 and Alt+F8 for window operations:
  ```bash
  gsettings set org.gnome.desktop.wm.keybindings begin-move "[]"
  gsettings set org.gnome.desktop.wm.keybindings begin-resize "[]"
  ```
* `gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'`
* Als je Budgie geïnstallerd hebt, dan Ctrl+Alt+Left/Right uitschakelen in de keyboard shortcuts (helemaal onderaan, bij de custom shortcuts)
* Als je een donker thema gebruikt, dan Firefox de lichte versie laten gebruiken voor widgets:
  * `about:config`: `widget.content.gtk-theme-override` instellen op `Adwaita` of `Pocillo` (bijvoorbeeld)
  * Bron: https://bugzilla.mozilla.org/show_bug.cgi?id=1283086
* Applicaties in andere workspaces niet in de launcher laten zien:
  `gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces true`


## Stack

```bash
echo 'deb http://mirror.transip.net/stack/software/deb/Ubuntu_18.04/ ./' | sudo tee /etc/apt/  sources.list.d/stack-client.list
wget -O - https://mirror.transip.net/stack/release.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install stack-client
```

# Other

Install Roboto font
