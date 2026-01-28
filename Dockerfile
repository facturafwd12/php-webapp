FROM php:8.2-apache

# Disable conflicting MPM modules and ensure only mpm_prefork is active
RUN a2dismod mpm_event mpm_worker 2>/dev/null || true && \
    a2enmod mpm_prefork

# Enable Apache rewrite module
RUN a2enmod rewrite

# Copy all PHP files to Apache root
COPY . /var/www/html/

# Fix permissions
RUN chown -R www-data:www-data /var/www/html

# Expose Apache port
EXPOSE 80
 
