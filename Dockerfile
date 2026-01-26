FROM php:8.2-apache

# Enable Apache rewrite (safe even if you don't use .htaccess)
RUN a2enmod rewrite

# Copy all PHP files to Apache root
COPY . /var/www/html/

# Fix permissions
RUN chown -R www-data:www-data /var/www/html

# Expose Apache port
EXPOSE 80
