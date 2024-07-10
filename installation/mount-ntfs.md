## NTFS disk mounting and linking directories

Source: https://help.ubuntu.com/community/InstallingANewHardDrive

1. `sudo apt install gparted dosfstools mtools`
2. Create the mount points:
   ```sh
   sudo mkdir /media/D
   sudo mkdir /media/E
   ```
3. Find out the UUIDs of your disks/partitions: `sudo blkid`
4. `sudo nano -Bw /etc/fstab` and then add:
   ```sh
   UUID=4E8E18C48E18A68D /media/D ntfs-3g (rw,nosuid,nodev,relatime,uid=1000,gid=1000,windows_names,iocharset=utf8,uhelper=udisks2) 0 2
   UUID=CC4C20274C200EB0 /media/E ntfs-3g (rw,nosuid,nodev,relatime,uid=1000,gid=1000,windows_names,iocharset=utf8,uhelper=udisks2) 0 2
   ```
   (you can get the mount options by mounting them through the UI, running `mount` and modifying the output)
5. ```sh
   rmdir ~/Documents
   ln -s /media/D/Users/Wout/Documenten ~/Documents
   rmdir ~/Pictures
   ln -s /media/D/Users/Wout/Afbeeldingen ~/Pictures
   rmdir ~/Videos ~/Music ~/Public
   ln -s /media/D/Users/Wout ~/Other
   ln -s /media/E/Temp ~/temp
   ```
