#!/bin/bash

# make necessary module directories
mkdir sites/all/modules/contrib
mkdir sites/all/modules/devel
mkdir sites/all/modules/features
mkdir sites/all/modules/custom

# disable some modules
drush dis shortcut -y
drush dis overlay -y
drush dis toolbar -y

# enable some modules
drush en ctools -y
drush en views -y
drush en views_ui -y
drush en jquery_update -y
drush en dates -y
drush en admin_menu -y
drush en admin_menu_toolbar -y
drush en token -y
drush en entity -y
drush en file_entity -y
drush en entity_token -y
drush en admin_views -y
drush en advanced_help -y
drush en module_filter -y
drush en features -y
drush en strongarm -y
drush en context -y
drush en context_ui -y
drush en rules -y
drush en rules_admin -y
drush en rules_ui -y
drush en fpa -y
drush en libraries -y
drush en entityreference -y
drush en entityreference_prepopulate -y
drush en pathauto -y
drush en panels -y
drush en panelizer -y

#devel stuff
mv sites/all/modules/contrib/devel sites/all/modules/devel/
drush en devel -y
drush en devel_generate -y

drush cc all
drush updb

# output
echo ""
echo ""
echo "Drupal 7 modules installation complete!"
echo ""
echo ""
