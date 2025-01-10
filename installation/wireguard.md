# Wireguard

## Client

```sh
sudo nmcli connection import type wireguard file client.conf
sudo nm-connection-editor # To disable connecting automatically
```

## Server

First, define the following variables:
```sh
network_interface=eth0
server_port=51822  # Default: 51820
server_ip4=xxx.xxx.xxx.xxx
```

Then, run the following commands:
```sh
sudo apt install -y wireguard qrencode
sudo chmod 700 /etc/wireguard
server_private_key="$(sudo wg genkey | sudo tee /etc/wireguard/server_private.key)"
server_public_key="$(sudo cat /etc/wireguard/server_private.key | wg pubkey | sudo tee /etc/wireguard/server_public.key)"
dns_servers="$(resolvectl dns eth0 | cut -d' ' -f4)"
private_ipv4_subnet="10.0.0."
private_ipv6_subnet="fda5:d56a:0a9c::"
sudo tee /etc/wireguard/wg0.conf > /dev/null <<EOF
[Interface]
Address = ${private_ipv4_subnet}1/24, ${private_ipv6_subnet}1/64

SaveConfig = true
PrivateKey = ${server_private_key}
PostUp = ufw route allow in on wg0 out on ${network_interface}
PostUp = iptables -t nat -I POSTROUTING -o ${network_interface} -j MASQUERADE
PreDown = ufw route delete allow in on wg0 out on ${network_interface}
PreDown = iptables -t nat -D POSTROUTING -o ${network_interface} -j MASQUERADE
ListenPort = ${server_port}  # Default: 51820

EOF

for name_with_ip_suffix in "wout,2" "wim,3" "rian,4"; do
#for name_with_ip_suffix in "wout,2"; do
    name=$(echo "${name_with_ip_suffix}" | cut -d, -f1)
    ip_suffix=$(echo "${name_with_ip_suffix}" | cut -d, -f2)
    echo $name
    client_private_key=$(sudo wg genkey | sudo tee /etc/wireguard/client_${name}_private.key)
    client_public_key=$(sudo cat /etc/wireguard/client_${name}_private.key | wg pubkey | sudo tee /etc/wireguard/client_${name}_public.key)
    sudo tee /etc/wireguard/client_${name}.conf > /dev/null <<EOF
[Interface]
PrivateKey = ${client_private_key}
Address = ${private_ipv4_subnet}${ip_suffix}/24
Address = ${private_ipv6_subnet}${ip_suffix}/64
DNS = ${dns_servers}

[Peer]
PublicKey = ${server_public_key}
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = ${server_ip4}:${server_port}
PersistentKeepalive = 25
EOF

    sudo tee -a /etc/wireguard/wg0.conf > /dev/null << EOF
[Peer]
PublicKey = ${client_public_key}
AllowedIPs = ${private_ipv4_subnet}${ip_suffix}/32

EOF

    sudo cat /etc/wireguard/client_${name}.conf | qrencode -t ansiutf8 | sudo tee /etc/wireguard/client_${name}_qr.txt
    sudo cat /etc/wireguard/client_${name}.conf | sudo qrencode -o /etc/wireguard/client_${name}_qr.png
done

sudo systemctl start wg-quick@wg0.service
sudo systemctl enable wg-quick@wg0.service
sudo systemctl status wg-quick@wg0.service
sudo wg show wg0

sudo ufw allow ${server_port}/udp
sudo ufw reload

sudo iptables -t nat -A POSTROUTING -s ${private_ipv4_subnet}0/24 -o ${network_interface} -j MASQUERADE
sudo mkdir -p /etc/iptables
sudo iptables-save | sudo tee /etc/iptables/rules.v4
```

## Sources

* https://docs.vultr.com/how-to-install-wireguard-vpn-on-ubuntu-24-04
* https://www.digitalocean.com/community/tutorials/how-to-set-up-wireguard-on-ubuntu-20-04
* https://unix.stackexchange.com/a/106666
