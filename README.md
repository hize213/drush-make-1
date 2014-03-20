drush-make
==========

Drush Make file and script to build a D7 site quickly with commonly used modules turned on with basic configuration. Good for spinning up a D7 site quickly to test a module.

The following command will create a new site in the directory called <dbname> with the database name also of <dbname>.

./maked7 <dbname>

The script also does a drush site-install, so you can immediately go to the site.

Admin and site information will be provided after install completes successfully.

The mysql username/password are hard coded to root/root in the shell script. You will have to edit to match your mysql username/password.
