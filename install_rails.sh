#!/bin/bash

############# HOW TO USE IT #############
### $1 -> ruby version
### ./install_rails.sh 1.9.2
#########################################

#install necessary libraries
sudo apt-get update
sudo apt-get install build-essential openssl libreadline6 libreadline-dev libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison pkg-config

if postgresql
  sudo apt-get install postgresql

# get the script to intall rvm then run it
bash < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer )

# make the access to rvm binaries
echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function' >> ~/.bash_profile

# reload the environment 
source ~/.bash_profile

# install necessary packages
rvm pkg install zlib --verify-downloads 1
rvm --skip-autoreconf pkg install readline --verify-downloads 1
rvm pkg install openssl --verify-downloads 1

# install ruby 
rvm install $1 --with-openssl-dir=$rvm_path/usr

# use the installed version as default
rvm use $1 --default

# rvm reinstall $1

# install soft to checkout and install all the gems
gem install bundler

echo 'YOUPIIII TOP COOOL'
