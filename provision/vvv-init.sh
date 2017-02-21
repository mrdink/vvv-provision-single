#!/usr/bin/env bash
source ../config/site-vars.sh

# Provision WordPress Stable
echo "Commencing $site_name Site Setup"

# Make a database, if we don't already have one
echo "Creating $site_name database (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS $database"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON $database.* TO $dbuser@localhost IDENTIFIED BY '$dbpass';"
echo -e "\n DB operations done.\n\n"

# Nginx Logs
mkdir -p ${VVV_PATH_TO_SITE}/log
touch ${VVV_PATH_TO_SITE}/log/error.log
touch ${VVV_PATH_TO_SITE}/log/access.log

# Install and configure the latest stable version of WordPress
if [[ ! -d "${VVV_PATH_TO_SITE}/public_html" ]]; then

  echo "Downloading WordPress Stable, see http://wordpress.org/"
  cd ${VVV_PATH_TO_SITE}
  curl -L -O "https://wordpress.org/latest.tar.gz"
  noroot tar -xvf latest.tar.gz
  mv wordpress public_html
  rm latest.tar.gz
  cd ${VVV_PATH_TO_SITE}/public_html

  echo "Configuring WordPress Stable..."
  noroot wp core config --dbname=$database --dbuser=$dbuser --dbpass=$dbpass --quiet --extra-php < ../config/wp-constants
PHP

    echo "Installing WordPress Stable..."
    noroot wp core install --url="$domain" --quiet --title="$site_name" --admin_name="$admin_user" --admin_email="$admin_email" --admin_password="$admin_pass"

    # Install all plugins in the plugins file using CLI
    noroot wp plugin install debug-bar
    noroot wp plugin install host-analyticsjs-local
    noroot wp plugin install jetpack
    noroot wp plugin install regenerate-thumbnails
    noroot wp plugin install theme-check
    noroot wp plugin install w3-total-cache
    noroot wp plugin install wp-force-login

    echo "Uninstalling Plugins..."
    noroot wp plugin uninstall hello
    noroot wp plugin uninstall akismet

else

  echo "Updating WordPress Stable..."
  cd ${VVV_PATH_TO_SITE}/public_html
  noroot wp core update

fi
