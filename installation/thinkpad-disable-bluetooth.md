# ThinkPad disable Bluetooth

```sh
sudo apt install tlp

sudo tee /etc/tlp.d/10-disable-bluetooth.conf > /dev/null <<EOF
DEVICES_TO_DISABLE_ON_STARTUP="bluetooth"
EOF
```
