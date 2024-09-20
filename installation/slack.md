# Slack

## Automatically (snap)

```sh
sudo snap install slack
```

## Automatically (deb)

**This does not work as of 2024-09-06**

```sh
curl -fsSL https://packagecloud.io/slacktechnologies/slack/gpgkey | gpg --dearmor | sudo tee /etc/apt/keyrings/slacktechnologies_slack-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/slacktechnologies_slack-archive-keyring.gpg] https://packagecloud.io/slacktechnologies/slack/ubuntu jammy main" | sudo tee /etc/apt/sources.list.d/slacktechnologies_slack.list > /dev/null
sudo apt update
sudo apt install slack
```

## Manually (deb)

1. Download .deb with `xdg-open "https://slack.com/downloads/instructions/linux?ddl=1&build=deb"`
2. Install with `sudo dpkg -i $(ls ~/Downloads/slack-desktop-* | sort | tail -n1)`
