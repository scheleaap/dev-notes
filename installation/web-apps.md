# Web apps

Add files like these to `/home/wout/.local/share/applications`:

```
#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Type=Application
Encoding=UTF-8
Name=Microsoft Teams
Exec=chromium-browser --profile-directory=Default --ignore-profile-directory-if-not-exists --app=https://teams.microsoft.com/v2/
Icon=/home/wout/Seafile/wout/app-icons/microsoft-teams.png
URL=https://teams.microsoft.com/v2/
Comment=Open https://teams.microsoft.com/v2/ in an app window.
```

## Google Meet

Create file `~/.local/share/applications/google-meet-qrn-imsx-abi.desktop`:

```
[Desktop Entry]
Type=Application
Encoding=UTF-8
Name=Team
Exec=chromium-browser --app=https://meet.google.com/aaa-bbbb-ccc --new-window
Icon=google-meet.png
Terminal=false
```

Store the icon in `~/.local/share/icons`.
