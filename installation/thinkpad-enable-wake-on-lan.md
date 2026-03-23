# ThinkPad enable Wake-on-Lan

```sh
sudo apt install tlp

sudo tee /etc/tlp.d/10-enable-wake-on-lan.conf > /dev/null <<EOF
WOL_DISABLE=N
EOF
```
