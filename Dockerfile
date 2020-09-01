# Set the base image for subsequent instructions
FROM php:7.4-cli

WORKDIR /app

RUN echo ":)" \
    # Update packages
    && apt-get update \
    # Install PHP and composer dependencies
    && apt-get install -qq git curl libmcrypt-dev libjpeg-dev libpng-dev libfreetype6-dev libbz2-dev \
    # Clear out the local repository of retrieved package files
    && apt-get clean \
    # Install needed extensions
    && docker-php-ext-install pdo_mysql zip \
    # Install Composer
    && curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    # Install Laravel
    && composer global require laravel/installer \
    && composer create-project --prefer-dist laravel/laravel . "7.*" \
    # Install Laravel Backup
    && composer require spatie/laravel-backup \
    && php artisan vendor:publish --provider="Spatie\Backup\BackupServiceProvider"
