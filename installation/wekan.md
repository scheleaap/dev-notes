# Wekan

## Snap

As of 2026-07, Wekan's UI is completely ugly & broken.

```sh
sudo snap install wekan
sudo snap set wekan root-url='http://localhost:3001/'
sudo snap set wekan port='3001'
sudo systemctl restart snap.wekan.wekan
```

## Docker Compose

1. ```sh
   sudo mkdir /opt/wekan-docker-compose
   sudo chown wout /opt/wekan-docker-compose
   cd /opt/wekan-docker-compose
   wget https://github.com/wekan/wekan/raw/refs/tags/v7.95/docker-compose.yml
   ```
1. In `/opt/wekan-docker-compose/docker-compse.yml`, make the following changes:
   ```
   <     image: ghcr.io/wekan/wekan:v7.20
   >     image: ghcr.io/wekan/wekan:latest

   <       - 3002:8080
   >       - 80:8080

   <       - ROOT_URL=http://localhost:3002  #   <=== using only at same laptop/desktop where Wekan is installed
   >       - ROOT_URL=http://localhost  #   <=== using only at same laptop/desktop where Wekan is installed
   ```
