# Windows

## WinApps

Installation:
1. Configure a Windows VM using Docker: https://github.com/winapps-org/winapps/blob/main/docs/docker.md
1. Install Dependencies:
    `sudo apt install -y curl dialog freerdp3-x11 git iproute2 libnotify-bin netcat-openbsd`
1. Create a WinApps Configuration File
1. Test FreeRDP:
    `xfreerdp3 /u:"Wout" /p:"wout" /v:127.0.0.1 /cert:tofu`
1. Run the WinApps Installer
    `bash <(curl https://raw.githubusercontent.com/winapps-org/winapps/main/setup.sh)`

To start/stop/etc the Docker container:
```sh
docker compose --file ~/.config/winapps/compose.yaml start
```

To install applications:
```sh
winapps-setup
```


## VirtualBox

To extract the license key from hardware:
```
sudo strings /sys/firmware/acpi/tables/MSDM
```

### See also

* https://leduccc.medium.com/prevent-activation-issues-on-your-qemu-windows-guest-with-oem-windows-licenses-5bf03ecf513d
* https://forums.virtualbox.org/viewtopic.php?t=107226
* https://www.virtualbox.org/manual/UserManual.html#changeacpicust
