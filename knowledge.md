### Set up nvim
[vim-plug github](https://github.com/junegunn/vim-plug#unix-linux)
```bash
sudo apt intall curl
sudo apt install stow
cd ~/.config/nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
sudo snap install pyright --classic
sudo apt install xclip

source %
PluginInstall
call mkdp#util#install()
```

### Search in vim

- \V - to use raw data (remember example with a.k.a.)
- \v - python behavior
- \_s - all space symbols
- \zs - use previous patterns as context. Everything after it will be a match
- \zs - use everything after match as context
- : s - replace
  * g - all replace on line
  * % - a whole file
- `<C-r><C-w>` - copy a word under cursor into command line

### Install python from source

```bash
sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
wget https://www.python.org/ftp/python/3.10.1/Python-3.10.1.tar.xz
mkdir .python with version
tar xfv Python*
cd Python3*
./configure --enable-optimizations --prefix=/home/slava/.python3.10.1
make
sudo make altinstall
nvim ~/.bashrc

export PATH=$PATH:/home/slava/.python3.10.1/bin/
```

Program to determine application's class
```bash
xprop | grep -i "class"
```

### tmux

```bash
sudo apt install tmux
nvim ~/.bashrc; export EDITOR='nvim'
sudo snap install ruby --classic
gem install tmuxinator
sudo apt install tmuxinator
```

### Russian in vim

```bash
git clone https://github.com/ierton/xkb-switch
cd xkb-switch
sudo apt-get install build-essential cmake libx11-dev libxext-dev libxtst-dev libxkbfile-dev
mkdir build && cd build
cmake ..
make
sudo make install
```

### ssh config 

##### create new user on server

```bash
adduser `newuser`
usermod -aG sudo `newuser`
sudo service ssh restart
```

##### ssh config example
```bash
Host github.com
        User git
        Hostname github.com
        PreferredAuthentications publickey
        IdentityFile /home/user/.ssh/id_rsa
```

##### Setting for root

```bash
sudo vim /etc/ssh/sshd_config
    AllowUsers www
    PermitRootLogin no
    PasswordAuthentication no
```

### open-vpn

```bash
wget https://git.io/vpn -O openvpn-install.sh
sudo bash ./openvpn-install.sh
```
