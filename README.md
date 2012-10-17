LinuxRubyInstaller
==================

A script to install rvm and ruby on Linux (Ubuntu but should work on debian based versions)

If you want to install ruby with rvm, simply run the install file
  > ./install.sh

If you need a specific version of ruby you can use the argument -v
  > ./install.sh -v 1.9.3

Sometimes it is usefull to have databases installed (in case of using Rails for example). In this case your can add a list of databases to install
  > .install -d postgresql,mysql

For now, only postgresql, mysql, sqlite3 and mongodb are supported

--

Hope this will be helpfull and feel free to contact me if you have some issues with other versions or anything else