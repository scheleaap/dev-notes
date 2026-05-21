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

First, enable custom CSS (e.g. https://www.reddit.com/r/FirefoxCSS/wiki/index/tutorials/).

```css
/* TAB GROUP COLORS
 * tab-group-color-* is used for expanded groups in light mode and collapsed groups in dark mode
 * tab-group-color-*-invert is used for expanded groups in dark mode
 * tab-group-color-*-pale is used for collapsed groups in light mode
  --tab-group-color-blue: var(--color-blue-70);
  --tab-group-color-blue-invert: var(--color-blue-20);
  --tab-group-color-blue-pale: var(--color-blue-0);
  --tab-group-color-purple: var(--color-purple-70);
  --tab-group-color-purple-invert: var(--color-purple-20);
  --tab-group-color-purple-pale: var(--color-purple-0);
  --tab-group-color-cyan: var(--color-cyan-70);
  --tab-group-color-cyan-invert: var(--color-cyan-20);
  --tab-group-color-cyan-pale: var(--color-cyan-0);
  --tab-group-color-orange: var(--color-orange-70);
  --tab-group-color-orange-invert: var(--color-orange-20);
  --tab-group-color-orange-pale: var(--color-orange-0);
  --tab-group-color-yellow: var(--color-yellow-70);
  --tab-group-color-yellow-invert: var(--color-yellow-20);
  --tab-group-color-yellow-pale: var(--color-yellow-0);
  --tab-group-color-pink: var(--color-pink-70);
  --tab-group-color-pink-invert: var(--color-pink-20);
  --tab-group-color-pink-pale: var(--color-pink-0);
  --tab-group-color-green: var(--color-green-70);
  --tab-group-color-green-invert: var(--color-green-20);
  --tab-group-color-green-pale: var(--color-green-0);
  --tab-group-color-red: var(--color-red-70);
  --tab-group-color-red-invert: var(--color-red-20);
  --tab-group-color-red-pale: var(--color-red-0);
  --tab-group-color-gray: #5e6a77;
  --tab-group-color-gray-invert: #99a6b4;
  --tab-group-color-gray-pale: #f2f9ff;
 */

:root {
  --tab-group-color-green: #107c10 !important;
  --tab-group-color-cyan: #00b294 !important;
  --tab-group-color-blue: #0078d7 !important;
  --tab-group-color-red: #e81123 !important;
  --tab-group-color-yellow: #ffb900 !important;
  --tab-group-color-pink: #ff0080 !important;
  --tab-group-color-orange: #ff7a00 !important;
}
```
