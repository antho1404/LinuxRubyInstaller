#!/bin/bash

############# HOW TO USE IT #############
### $1 -> ruby version
### ./install_rails.sh 1.9.2
#########################################

VERSION="1.9.3"
DATABASES=[]
DIR=`dirname $0`

usage() {
  echo usage: $0 options
  echo ""
  echo This script install ruby using rvm.
  echo ""
  echo options:
  echo -h  Help
  echo -v  Specify the version of ruby you want \($VERSION by default\)
  echo -d  Databases you want to install \(empty by default\) \[postgresql,mysql,mongodb,sqlite3\]
}

install_dependencies() {
  #install necessary libraries
  sudo apt-get update
  sudo apt-get -y install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion nodejs pkg-config
}

install_rvm() {
  # get rvm script intaller and run it
  curl -L get.rvm.io | bash -s stable

  # make the access to rvm binaries
  echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function' >> ~/.bash_profile

  # reload the environment
  source ~/.rvm/scripts/rvm
  source ~/.bash_profile
}

install_ruby() {
  # install ruby 
  rvm install $VERSION

  # use the installed version as default
  rvm use $VERSION --default
  
  # install soft to checkout and install all the gems
  gem install bundler
}

install_databases() {
  for x in $DATABASES
  do
    /home/antho/$DIR/databaseInstaller/$x.sh
  done
}

while getopts "hv:d:" OPTION
do
  case $OPTION in
    h)
      usage
      exit 1
      ;;
    v)
      VERSION=$OPTARG
      ;;
    d)
      DATABASES=$(echo $OPTARG | tr "," "\n")
      ;;
    ?)
      usage
      exit
      ;;
 esac
done

if [[ -z $VERSION ]]
then
  usage
  exit 1
fi

install_dependencies
install_rvm
install_ruby
install_bundler
install_databases

echo 'YOUPIIII TOP COOOL'
