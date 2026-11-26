# ThinkPad battery charging

```sh
sudo apt install tlp

sudo tee /etc/tlp.d/10-battery-charging.conf > /dev/null <<EOF
START_CHARGE_THRESH_BAT0=60
STOP_CHARGE_THRESH_BAT0=85
START_CHARGE_THRESH_BAT1=60
STOP_CHARGE_THRESH_BAT1=85
EOF

sudo tlp start
```

To charge to the threshold regardless the current charge
```sh
sudo tlp chargeonce BAT0
sudo tlp chargeonce BAT1
```
