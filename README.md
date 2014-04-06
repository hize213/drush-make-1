drush-make
==========

This script in combination with the associated drush make file is set up to download a specific set of non core modules and do a complete site install. It will also install adaptive theme and set up the subtheme. It initializes a git repo and git clones my drush gitignore files from github (requires user interaction for github pw). It adds a line to /etc/hosts for local virtualization and sets up the virtual host block in my vhosts.conf. After installation the site is 100% accessible and ready to work on.

The following command will create a new site in the directory called <dbname> with the database name also of <dbname>. Theme and hosts files will also reflect <dbname>. After rebooting MAMP, go to <dbname>/ in the browser.

command to run from within this dir:
./maked7 <dbname>

Admin information is hardcoded in the script. Admin and site information will be provided after install completes successfully.
