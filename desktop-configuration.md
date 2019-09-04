# Eigen configuatie

## Software installation

## Commitizen

https://commitizen.github.io/cz-cli/


### Emoji Picker

```
sudo add-apt-repository ppa:ys/emojione-picker
sudo apt-get update
sudo apt-get install emojione-picker
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
apt-get install unity-tweak-tool
```

* Unity Tweak Tool
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
