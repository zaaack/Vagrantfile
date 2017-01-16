#!/usr/bin/env bash

# Add the code to Vagrantfile
# config.vm.provision :shell, path: "bootstrap.sh"

# change source mirror

cd /etc/apt/
if [[ ! -f sources.list.bak ]]; then
  mv sources.list sources.list.bak
  bash -c "cat /vagrant/sources.list.mirror sources.list.bak > sources.list"
  echo "add aliyun mirror to source.list"
  apt-get update -y
  sudo apt-get install curl -y
fi

# install build tools
apt-fast install -y make build-essential libsnappy-dev zlib1g-dev libbz2-dev libgflags-dev libsqlite3-dev gcc g++

# install user tools
apt-fast install -y git zsh wget nethogs htop vim proxychains
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
echo 'alias vi=vim' >> ~/.zshrc

MEOW_INSTALLDIR=/usr/local/bin
cd /usr/local/bin
curl -L git.io/meowproxy | bash
mv /usr/local/bin/MEOW /usr/local/bin/meow

# install nodejs
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-fast install -y nodejs

# install nginx, mongodb
apt-fast install -y nginx mongodb

# install yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources
echo 'export PATH="$PATH:`yarn global bin`"' >> ~/.zshrc

# node tools
yarn global add http-server n


# install rocksdb
