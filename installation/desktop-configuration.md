# Eigen configuatie

Installation guide for stuff I do not always need.

## Software installation

Empty.


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


## GitHub CLI

```sh
cd /tmp
wget https://github.com/cli/cli/releases/download/v0.6.2/gh_0.6.2_linux_amd64.deb
sudo dpkg -i gh_0.6.2_linux_amd64.deb
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

* Als je Budgie geïnstallerd hebt, dan Ctrl+Alt+Left/Right uitschakelen in de keyboard shortcuts (helemaal onderaan, bij de custom shortcuts)
* Als je een donker thema gebruikt, dan Firefox de lichte versie laten gebruiken voor widgets:
  * `about:config`: `widget.content.gtk-theme-override` instellen op `Adwaita` of `Pocillo` (bijvoorbeeld)
  * Bron: https://bugzilla.mozilla.org/show_bug.cgi?id=1283086


## ZSH

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo apt-get install fonts-powerline
in ~/.zshrc:
* ZSH_THEME="agnoster"
* plugins=(git kube-ps1)
* add `prompt_context(){}`
