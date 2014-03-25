#!/bin/bash
# constants
readonly DB_USER="root"
readonly DB_PASS="root"
readonly DB_HOST="localhost"
readonly ADMIN_NAME="superadmin"
readonly ADMIN_PASS="admin"
readonly ADMIN_MAIL="cbfannin@gmail.com"

# check for argument
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

# ctools, views, proper toolbar.
drush en admin_menu -y
drush en admin_menu_toolbar -y

# disable some modules
drush dis toolbar -y
drush dis shortcut -y
drush dis overlay -y

# ctools, views, proper toolbar.
drush en admin_menu -y
drush en admin_menu_toolbar -y
drush en module_filter -y
drush en fpa -y
drush en diff -y
drush en ctools -y
drush en views -y
drush en views_ui -y

drush en advanced_help -y
drush en environment_indicator -y

drush en features -y
drush en strongarm -y

drush en entity -y
drush en entity_token -y
drush en rules -y

drush en token -y
drush en libraries -y

#devel stuff
drush en devel -y
drush en devel_generate -y

drush en entityreference -y
drush en entityreference_prepopulate -y
drush en views_bulk_operations -y

drush cc all

# output
echo ""
echo ""
echo "Drupal 7 site install completed successfully!"
echo ""
echo "SITE INFORMATION:"
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


