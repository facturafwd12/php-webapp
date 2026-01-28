FROM php:8.2-apache

# 1. Enable mod_rewrite (MPM prefork is already enabled by default)
RUN a2enmod rewrite

# 2. Allow .htaccess files (replaces your sed command with a cleaner env var approach)
ENV APACHE_DOCUMENT_ROOT /var/www/html
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Note: The official image defaults AllowOverride to None.
# If you rely on .htaccess, you can use this specific command to enable it:
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# 3. Copy your application source
COPY . /var/www/html/

# 4. Set ownership
RUN chown -R www-data:www-data /var/www/html

# EXPOSE is 80 by default in this image, but you can keep it explicit
EXPOSE 80

# CMD is handled automatically by the base image (apache2-foreground)
