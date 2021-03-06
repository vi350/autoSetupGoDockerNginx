#!/bin/bash
apt update
apt install htop
apt install tmux
apt install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io
wget https://go.dev/dl/go1.18.1.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.18.1.linux-amd64.tar.gz
rm /root/go1.18.1.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
apt install nginx
systemctl enable nginx
mkdir ~/crts
cd ~
wget https://raw.githubusercontent.com/vi350/autoSetupGoDockerNginx/master/nginx.conf
mv nginx.conf /etc/nginx/nginx.conf
systemctl reload nginx
#TODO: wget nginx conf own template
cd /home || mkdir /home
mkdir admin
cp ~/.bashrc /home/admin/.bashrc
useradd -g admin -s /bin/bash admin
chown admin:admin /home/admin
chown admin:admin /home/admin/.bashrc
echo "[ -e ~/.bashrc ] && source ~/.bashrc" >> /etc/profile
groupadd docker
usermod -aG docker admin
systemctl restart docker
passwd admin
#TODO: auto deny password login in favor of keys
#TODO: delete docker prerouting from iptables + ufw
#TODO: autocreate services
#TODO: autologin to github for private repos
