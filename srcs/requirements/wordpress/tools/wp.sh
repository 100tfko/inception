#!/bin/sh

# Wait for MariaDB (improved security)
echo "Waiting for MariaDB..."
sleep 5

# Install WordPress if not present
if [ ! -f wp-config.php ]; then
    echo "Installing WordPress..."
    wp core download --allow-root
    wp config create \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=$MYSQL_HOSTNAME \
        --allow-root
    wp core install \
        --url="https://$DOMAIN_NAME" \
        --title="$WORDPRESS_TITLE" \
        --admin_user="$WORDPRESS_ADMIN" \
        --admin_password="$WORDPRESS_ADMIN_PASS" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --skip-email \
        --allow-root

    # Create additional regular user
    wp user create "$WORDPRESS_USER" "$WORDPRESS_EMAIL" \
        --user_pass="$WORDPRESS_USER_PASS" \
        --role=author \
        --allow-root

    wp theme install twentytwentyfour --activate --allow-root
    echo "WordPress installed successfully!"
else
    echo "WordPress already installed."
fi

# Update site URL using environment variable instead of hardcoded value
wp option update home "https://$DOMAIN_NAME" --allow-root
wp option update siteurl "https://$DOMAIN_NAME" --allow-root

# Ensure proper permissions
chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;

# Start PHP-FPM
echo "Starting PHP-FPM..."
exec php-fpm7.4 -F