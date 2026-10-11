# Firefox

## Installation

Based on https://www.debugpoint.com/remove-firefox-snap-ubuntu/#Method_1_Use_PPA_Recommended

Add the following lines to `/etc/apt/preferences.d/firefox-no-snap`:
```
Package: firefox*
Pin: release o=Ubuntu*
Pin-Priority: -1
```

Run:
```sh
sudo apt purge firefox
sudo add-apt-repository ppa:mozillateam/ppa
sudo apt-get update
sudo apt install firefox
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox
```

## Configuration

Based on https://www.reddit.com/r/FirefoxCSS/wiki/index/tutorials/:

1. Enable custom CSS by setting `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`
2. Create `chrome/userChrome.css` and `chrome/userContent.css` in the profile directory
3. Add the following to `chrome/userChrome.css`:

```css
/* TAB GROUP COLORS
 * tab-color-* is used for expanded groups in light mode and collapsed groups in dark mode
 * tab-color-*-invert is used for expanded groups in dark mode
 * tab-color-*-pale is used for collapsed groups in light mode
  --tab-color-blue: var(--color-blue-70);
  --tab-color-blue-invert: var(--color-blue-20);
  --tab-color-blue-pale: var(--color-blue-0);
  --tab-color-purple: var(--color-purple-70);
  --tab-color-purple-invert: var(--color-purple-20);
  --tab-color-purple-pale: var(--color-purple-0);
  --tab-color-cyan: var(--color-cyan-70);
  --tab-color-cyan-invert: var(--color-cyan-20);
  --tab-color-cyan-pale: var(--color-cyan-0);
  --tab-color-orange: var(--color-orange-70);
  --tab-color-orange-invert: var(--color-orange-20);
  --tab-color-orange-pale: var(--color-orange-0);
  --tab-color-yellow: var(--color-yellow-70);
  --tab-color-yellow-invert: var(--color-yellow-20);
  --tab-color-yellow-pale: var(--color-yellow-0);
  --tab-color-pink: var(--color-pink-70);
  --tab-color-pink-invert: var(--color-pink-20);
  --tab-color-pink-pale: var(--color-pink-0);
  --tab-color-green: var(--color-green-70);
  --tab-color-green-invert: var(--color-green-20);
  --tab-color-green-pale: var(--color-green-0);
  --tab-color-red: var(--color-red-70);
  --tab-color-red-invert: var(--color-red-20);
  --tab-color-red-pale: var(--color-red-0);
  --tab-color-gray: #5e6a77;
  --tab-color-gray-invert: #99a6b4;
  --tab-color-gray-pale: #f2f9ff;
 */

:root {
  --tab-color-green: #107c10 !important;
  --tab-color-cyan: #00b294 !important;
  --tab-color-blue: #0078d7 !important;
  --tab-color-red: #e81123 !important;
  --tab-color-yellow: #ffb900 !important;
  --tab-color-pink: #ff0080 !important;
  --tab-color-orange: #ff7a00 !important;
}
```
