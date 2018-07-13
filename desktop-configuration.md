# Eigen configuatie

## Software installation

### Atom
```
sudo add-apt-repository ppa:webupd8team/atom 
sudo apt-get update
sudo apt-get install atom
```

## Commitizen

https://commitizen.github.io/cz-cli/


### Emoji Picker

```
sudo add-apt-repository ppa:ys/emojione-picker
sudo apt-get update
sudo apt-get install emojione-picker
```


### IntelliJ

```
sudo add-apt-repository ppa:mmk2410/intellij-idea
sudo apt-get update
sudo apt-get install intellij-idea-community
```

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

## Ubuntu

```
apt-get install compizconfig-settings-manager unity-tweak-tool
```

* Normal settings
  * 
* Compiz Settings Manager
  * Ubuntu Unity Plugin -> Switcher
    * Disable Show Desktop in the Switcher
    * Disable the mouse in the Switcher
    * Alle keyboard shortcuts verwijderd
  * Application Switcher ingeschakeld
* Unity Tweak Tool
  * Launcher
    * Minimize single window applications on click (/)
  * Search
    * Show "More suggestions" (x)
  * Panel
    * Configure clock
  * Web Apps
    * _Disable everything_
  * Additional
    * Notifications: All displays
  * Workspace settings
    * _Configure_
  * Fonts:
    * Default font: 9
    * Document font: 9
    * Monospace font: 11
    * Window title font: 11

## Java

Oracle JDK:
```
sudo apt-add-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
```


## MySQL / MariaDB

Toegevoegd aan `/etc/mysql/mysql.conf.d/mysqld.cnf`:

```
#sql_mode="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
sql_mode="STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
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


# Other

Install Roboto font
