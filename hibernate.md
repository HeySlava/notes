[Copy from git article](https://gist.github.com/klingtnet/c972b8182e4e2818d6d551b0cbeac44b)

This guide is based on the [hibernate article](https://wiki.archlinux.org/index.php/Power_management/Suspend_and_hibernate#Hibernation) from the Arch wiki.

- edit `/etc/default/grub` and add `resume` as well as `resume_offset` kernel parameters
  - `resume=UUID=abcd-efgh` contains the UUID of the partition on which the swapfile resides. In most cases the `swapfile` resides in `root`, to identify the `root` parition's UUID run `blkid` or `lsblk -O`.
  - `resume_offset=1234` is the offset of the swapfile from the partition start. The offset is the first entry in the `physical_offset` column of the output of `filefrag -v /swapfile`.
  - update grub: `grub-mkconfig -o /boot/grub/grub.cfg`
  - example: `GRUB_CMDLINE_LINUX_DEFAULT="resume=UUID=75972c96-f909-4419-aba4-80c1b74bd605 resume_offset=1492992"`
- add the `resume` module hook to `/etc/mkinitcpio.conf`:
  - `HOOKS="base udev resume autodetect ...`
  - rebuild the initramfs `mkinitcpio -p linux`
- check if everything works: `systemctl hibernate`
