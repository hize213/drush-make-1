#!/bin/bash
# constants
readonly DB_USER="root"
readonly DB_PASS="root"
readonly DB_HOST="localhost"
readonly ADMIN_NAME="superadmin"
readonly ADMIN_PASS="admin"
readonly ADMIN_MAIL="admin@gigcitycode.com"

# check for dbname argument
if [[ -z "$1" ]]; then
  echo "Arguments needed <dbname>"
  exit 1
fi

# Use specified drush makefile
drush make drupal7.drush.make $1 -y
if [[ "$?" -ne 0 ]]; then
  echo "Something went wrong, did not make directory"
  exit 1
fi

cd $1
drush si --db-url=mysqli://$DB_USER:$DB_PASS@$DB_HOST/$1 --account-name=$ADMIN_NAME --account-pass=$ADMIN_PASS --site-name=$1 --site-mail=$ADMIN_MAIL -y

# disable some modules
drush dis shortcut -y
drush dis overlay -y

# enable some modules
drush en ctools -y
drush en views -y
drush en views_ui -y
drush en admin_menu -y
drush en admin_views -y
drush en adminimal_admin_menu -y
drush en advanced_help -y
drush en module_filter -y
drush en features -y
drush en strongarm -y
drush en context -y
drush en entity_token -y
drush en token -y
drush en rules -y
drush en fpa -y
drush en libraries -y
drush en entityreference -y
drush en entityreference_prepopulate -y
drush en pathauto -y
drush en panels -y
drush en panelizer -y
drush en jquery_update -y

#devel stuff
drush en devel -y
drush en devel_generate -y

#theme defaults
drush vset admin_theme adminimal_theme

drush cc all

#initiate git repo and clone custom drupal .gitignore
git init
git clone https://github.com/agentofcode/gitignore.git
mv gitignore/Drupal.gitignore .gitignore
sudo rm -R gitignore
git add .
git commit -m "Initial Commit"

# move new site to htdocs
cd ..
mv $1 ~/htdocs/

# create virtual host for this site
echo "127.0.0.1       $1" | sudo tee -a /etc/hosts
echo "" >> /Applications/MAMP/conf/apache/vhosts.conf
echo "#$1" >> /Applications/MAMP/conf/apache/vhosts.conf
echo "<VirtualHost *:80>" >> /Applications/MAMP/conf/apache/vhosts.conf
echo "  DocumentRoot \"/Users/cbfannin/htdocs/$1/\"" >> /Applications/MAMP/conf/apache/vhosts.conf
echo "  ServerName $1" >> /Applications/MAMP/conf/apache/vhosts.conf
echo "</VirtualHost>" >> /Applications/MAMP/conf/apache/vhosts.conf 

#restart MAMP apache and mysql servers
#cd /Applications/MAMP/bin
#sudo ./stop.sh
#sudo ./start.sh

# output
echo ""
echo ""
echo "Drupal 7 site install completed successfully!"
echo "---------------------------------------------"
echo "site name: $1"
echo "admin name: $ADMIN_NAME"
echo "admin pass: $ADMIN_PASS"
echo "admin mail: $ADMIN_MAIL"
echo ""
echo "DB INFORMATION:"
echo "---------------------------------------------"
echo "db name: $1"
echo "db user: $DB_USER"
echo "db pass: $DB_PASS"
echo "db host: $DB_HOST"
echo ""
echo ""
echo "---------------------------------------------"
echo "------ DON'T FORGET TO RESTART MAMP!! -------"
echo "---------------------------------------------"
echo ""
echo ""
