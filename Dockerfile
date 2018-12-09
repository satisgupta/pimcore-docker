#Ubuntu
FROM ubuntu:18.04

MAINTAINER Satish Gupta

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -yq --no-install-recommends \
    apt-utils \
    curl \
    # Install apache
    apache2 \
    # Install php 7.2
    libapache2-mod-php7.2 \
    php7.2-mysql \
    php7.2-cli \
    php7.2-json \
    php7.2-curl \
    php7.2-gd \
    php7.2-ldap \
    php7.2-mbstring \
    php7.2-soap \
    php7.2-xml \
    php7.2-zip \
    php7.2-intl \
    php-imagick \
    locales \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
    
# Set locales
RUN locale-gen en_US.UTF-8 en_GB.UTF-8 de_DE.UTF-8 es_ES.UTF-8 fr_FR.UTF-8 it_IT.UTF-8 km_KH sv_SE.UTF-8 fi_FI.UTF-8

RUN a2enmod rewrite expires

# Configure PHP
ADD php.ini /etc/php/7.2/apache2/conf.d/

# Copy web direcotry and setup work directory
COPY webapp /var/www/html

WORKDIR /var/www/html

CMD ["apachectl", "-D", "FOREGROUND"]
EXPOSE 80