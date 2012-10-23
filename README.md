LinuxRubyInstaller
==================

A script to install ruby on Linux (tested on Ubuntu but should work on Debian based versions)

If you want to install the latest version of ruby with rvm, simply run the install file
  > ./install.sh

If you need a specific version of ruby you can use the argument -v
  > ./install.sh -v 1.9.3

You can also use **rbenv** instead of **rvm**
  > ./install.sh -e rbenv 

Sometimes it is usefull to have databases installed (in case of using Rails for example). In this case your can add a list of databases to install
  > .install -d postgresql,mysql

For now, only postgresql, mysql, sqlite3 and mongodb are supported

--

Hope this will be helpfull and feel free to contact me if you have some issues with other versions or anything else