# Web apps

Add files like these to `~/.local/share/applications`.

## Google Meet

Create file `~/.local/share/applications/google-meet-qrn-imsx-abi.desktop`:

```
[Desktop Entry]
Type=Application
Encoding=UTF-8
Name=Team
Exec=chromium-browser --app=https://meet.google.com/aaa-bbbb-ccc --new-window
Icon=XXX/app-icons/google-meet.png
Terminal=false
```

Store the icon in `~/.local/share/icons`.

## Microsoft Teams

```
#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Type=Application
Encoding=UTF-8
Name=Microsoft Teams
Exec=chromium-browser --profile-directory=Default --ignore-profile-directory-if-not-exists --app=https://teams.microsoft.com/v2/
Icon=XXX/app-icons/microsoft-teams.png
URL=https://teams.microsoft.com/v2/
Comment=Open https://teams.microsoft.com/v2/ in an app window.
```

## Slack

```
#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Type=Application
Encoding=UTF-8
Name=Slack (web app)
Exec=chromium-browser --profile-directory=Default --ignore-profile-directory-if-not-exists --app=https://app.slack.com/client/AAAAAAAAAAA
Icon=XXX/app-icons/slack.svg
URL=https://app.slack.com/client/AAAAAAAAAAA
Comment=Open https://app.slack.com/client/AAAAAAAAAAA in an app window.
```
