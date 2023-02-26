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


Conf to check:

/etc/systemd/sleep.conf
/etc/systemd/logind.conf


[Arch forum discussion](https://bbs.archlinux.org/viewtopic.php?id=281373)  
[github issue](https://github.com/systemd/systemd/issues/25269)

If I want suspend-then-hibernate, there is a problem in systemd 252. In 252 in goes to hibernate ONLY in case is battery less that 5 %.

I want it work after fixed amount of time. So, I downgraded it to version 251. How to do it:


```bash
# in case I do not have it locally
wget https://archive.archlinux.org/packages/s/systemd/systemd-251-1-x86_64.pkg.tar.zst
wget https://archive.archlinux.org/packages/s/systemd/systemd-251-1-x86_64.pkg.tar.zst.sig
gpg --keyserver keyserver.ubuntu.com --recv-keys 0x9741E8AC
gpg --verify systemd-251-1-x86_64.pkg.tar.zst.sig
sudo pacman -U --needed --noconfirm systemd-251-1-x86_64.pkg.tar.zst

# from cache
ls /var/cache/pacman/pkg/systemd-*
sudo pacman -U /path/to/cached/packages

# check version
systemctl --version
```

```bash
# /etc/systemd/sleep.conf
[Sleep]
AllowSuspend=yes
AllowHibernation=yes
AllowSuspendThenHibernate=yes
AllowHybridSleep=yes
SuspendMode=suspend
SuspendState=mem standby freeze
HibernateMode=platform shutdown
HibernateState=disk
HybridSleepMode=suspend platform shutdown
HybridSleepState=disk
HibernateDelaySec=15min

# /etc/systemd/logind.conf
[Login]
HandleLidSwitch=suspend-then-hibernate
HandleLidSwitchExternalPower=suspend-then-hibernate
HandleLidSwitchDocked=suspend-then-hibernate
```
