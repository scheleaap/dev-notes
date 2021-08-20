# Firmware upgrades

1. Run `fwupdmgr get-updates` to get a list of available updates (check for items with a "Device ID" field).
2. Run `fwupdmgr get-devices` to get the device ID of the device you want to update.
3. Run `fwupdmgr update <device id>` to apply an update to a device.
4. Reboot after every update.

See also `fwupdmgr --help`.
