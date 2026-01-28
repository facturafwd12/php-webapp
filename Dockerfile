FROM php:8.2-apache

# 1. Enable mod_rewrite for URL routing
RUN a2enmod rewrite

# 2. Allow .htaccess files to work (Standard fix)
# This replaces "AllowOverride None" with "AllowOverride All" in the main config
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# 3. Copy your application source code
COPY . /var/www/html/

# 4. Set correct permissions so Apache can read/write
RUN chown -R www-data:www-data /var/www/html

# 5. Expose the standard HTTP port
EXPOSE 80
