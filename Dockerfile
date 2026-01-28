FROM php:8.2-apache

# Disable all other MPMs first
RUN a2dismod mpm_event mpm_worker || true

# Enable prefork (required for PHP)
RUN a2enmod mpm_prefork rewrite

# Copy app
COPY . /var/www/html/

# Fix permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
