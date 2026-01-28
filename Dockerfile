FROM php:8.2-cli

# Install Apache manually
RUN apt-get update && apt-get install -y apache2 \
    && rm -rf /var/lib/apt/lists/*

# Enable required modules
RUN a2enmod rewrite mpm_prefork

# Disable other MPMs HARD
RUN a2dismod mpm_event mpm_worker || true

# Allow .htaccess
RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

# Copy app
COPY . /var/www/html/
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

# Start Apache manually (IMPORTANT)
CMD ["apachectl", "-D", "FOREGROUND"]
