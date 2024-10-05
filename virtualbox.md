sudo apt update && sudo apt upgrade
pip install ansible
Guests mode:
sudo apt install gcc make perl python3-pip
Devices -> insert guest addition cd image

`cd /media/<username>/...`
`./autorun.sh`
`reboot`

# setup virtualbox for ubuntu

[setting up an ubuntu jammy (22.04) development machine (beginner) anthony explains #429](https://www.youtube.com/watch?v=tSUlg3yN4-k&t=772s)

- system -> processor -> enable PAE/NX
- system -> processor -> enable nested VT -x/AMD-V

- display -> screen -> video Memory full
- display -> screen -> enable 3d acceleration

Shared folder are avaialbe only after gurst addition. To be able to work with it go to the /media and current user to vboxsf group

## Modes
Full screen mode does not work correctly with i3 - right ctrl + F
Seamless also is not very comfortable - right ctrl + L
Scalled mode is good - right ctrl + C

Switch to normal view - right ctrl + L

### ssh
- settings -> network -> advanced -> port Forwarding
```
name: ssh
host ip: 127.0.0.1
Host port: 2222
Gurst port: 22
```

### Setup ssh
```bash
sudo apt install openssh-server
sudo systemctl start ssh
sudo systemctl enable ssh
```


# problems
The VirtualBox Linux kernel driver is either not loaded or not set up correctly. Please reinstall virtualbox-dkms package and load the kernel module by executing  'modprobe vboxdrv'

https://askubuntu.com/questions/920689/how-can-i-fix-this-modprobe-vboxdrv-error-in-virtualbox-error-could-not-inse
