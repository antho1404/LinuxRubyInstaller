#!/usr/bin/env bash

VERSION="1.9.3"
ENVIRONMENT="rvm"
DATABASES=[]
DIR=`dirname $0`

usage() {
  echo ""
  echo "usage: $0 options"
  echo ""
  echo "This script install ruby on Debian based distributions."
  echo ""
  echo "options:"
  echo "  -h  Help"
  # echo "  -e  Specify the environment for ruby ($ENVIRONMENT by default) [rvm,rbenv]"
  echo "  -v  Specify the version of ruby you want ($VERSION by default)"
  echo "  -d  Databases you want to install (empty by default) [postgresql,mysql,mongodb,sqlite3]"
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

install_rbenv() {
  git clone git://github.com/sstephenson/rbenv.git ~/.rbenv

  mkdir -p ~/.rbenv/plugins
  git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins
  
  echo '' >> ~/.bashrc
  echo '### Load rbenv environment' >> ~/.bashrc
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  exec $SHELL
}

install_ruby() {
  if [ $ENVIRONMENT = "rvm" ]
  then
    # install ruby 
    rvm install $VERSION

    # use the installed version as default
    rvm use $VERSION --default
  fi

  if [ $ENVIRONMENT = "rbenv" ]
  then
    rbenv install $VERSION
    rbenv rehash
    rbenv global $VERSION
  fi
}

install_bundler() {
  # install soft to checkout and install all the gems
  gem install bundler
}

install_databases() {
  for x in $DATABASES
  do
    $DIR/databaseInstaller/$x.sh
  done
}




while getopts "he:v:d:" OPTION
do
  case $OPTION in
    h)
      usage
      exit 1
      ;;
    e)
      # uncomment to test using rbenv
      #ENVIRONMENT=$OPTARG
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

echo "You will install ruby $VERSION using $ENVIRONMENT and $DATABASES adaptaters"
echo "Are you agree ? (Y/n)"
read answer

if [ $answer = "Y" ]
then
  install_dependencies
  if [ $ENVIRONMENT = "rvm" ]
  then
    install_rvm
  fi
  if [ $ENVIRONMENT = "rbenv" ]
  then
    install_rbenv
  fi
  install_ruby
  install_bundler
  install_databases

  echo 'YOUPIIII TOP COOOL'
else
  usage
fi