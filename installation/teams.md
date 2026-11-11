# Teams for Linux

Source: https://repo.teamsforlinux.de/install.sh

```sh
sudo mkdir -p /etc/apt/keyrings
sudo wget -qO /etc/apt/keyrings/teams-for-linux.asc https://repo.teamsforlinux.de/teams-for-linux.asc
sudo tee /etc/apt/sources.list.d/teams-for-linux.sources > /dev/null << EOF
Types: deb
URIs: https://repo.teamsforlinux.de/debian/
Suites: stable
Components: main
Architectures: amd64 arm64
Signed-By: /etc/apt/keyrings/teams-for-linux.asc
EOF
sudo apt update && sudo apt install teams-for-linux
```
