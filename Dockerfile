# Based on work from cytopia
# Docker setup for DVWA that allows you to start and use DVWA in one continer
# docker built -t this-dvwa .
# docker run -rm -p 8080:80 this-dvwa
# Login to http://localhost:8080 with default credentials

FROM php:8.2-apache as builder
# Set PHP version
ENV VERSION=8.1
# Install requirements
RUN set -eux \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		git \
		ca-certificates \
	&& update-ca-certificates

# Get DVWA
RUN set -eux \
	&& git clone https://github.com/digininja/DVWA /DVWA \
	&& rm -rf /DVWA/.git \
	&& rm -rf /DVWA/.github \
	&& rm -rf /DVWA/.gitignore \
	&& rm -rf /DVWA/php.ini

# Disable SQLITE
RUN set -eux \
	&& sed -i'' "s/if (\$_DVWA\['SQLI_DB'\]/if ('no'/g" /DVWA/dvwa/includes/dvwaPage.inc.php \
	&& sed -i'' 's/[[:space:]]SQLITE)/"SQLITE")/g' /DVWA/dvwa/includes/dvwaPage.inc.php

# Get Adminer
RUN set -eux \
	&& URL="$( \
		curl -sS --fail -k https://www.adminer.org/ \
		| grep -Eo 'https://github.com/vrana/adminer/releases/download/v[.0-9]+/adminer-[.0-9]+-mysql-en.php' \
	)" \
	&& curl -sS --fail -k -L "${URL}" > /adminer.php


FROM php:8.2-apache

# Satisfy MariaDB requirements
RUN set -eux \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		mariadb-server \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/mysqld/ \
    && chown mysql:mysql /run/mysqld


# Satisfy PHP requirements
RUN set -eux \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		libpng-dev \
		ca-certificates \
	&& update-ca-certificates \
	&& docker-php-ext-install gd \
	&& docker-php-ext-install mysqli \
	&& docker-php-ext-install pdo_mysql \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Satisfy Application requirements
RUN set -eux \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		iputils-ping \
		netcat \
		python3 \
		strace \
		sudo \
		telnet \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Set Environment Variables

ENV RECAPTCHA_PRIV_KEY=${RECAPTCHA_PRIV_KEY:-}
ENV RECAPTCHA_PUB_KEY=${RECAPTCHA_PUB_KEY:-}
ENV SECURITY_LEVEL=${SECURITY_LEVEL:-low}
ENV PHPIDS_ENABLED=${PHPIDS_ENABLED:-0}
ENV PHPIDS_VERBOSE=${PHPIDS_VERBOSE:-0}
ENV PHP_DISPLAY_ERRORS=${PHP_DISPLAY_ERRORS:-0}
# Localhost does not work here becasue it means something else in docker
ENV MYSQL_HOSTNAME=127.0.0.1
ENV MYSQL_DATABASE=dvwa
ENV MYSQL_USERNAME=dvwa
ENV MYSQL_PASSWORD=p@ssw0rd


# Copy source
COPY --from=builder /DVWA/ /var/www/html/
COPY --from=builder /adminer.php /var/www/html/adminer.php
COPY ./config.inc.php /var/www/html/config/config.inc.php
COPY ./mysql_init.sql /var/www/mysql_init.sql
COPY ./entrypoint.sh/ /entrypoint.sh

# FIXUP SQL init file
RUN set -eux \
	&& sed -i'' "s/\${db_name}/${MYSQL_DATABASE}/g" /var/www/mysql_init.sql \
	&& sed -i'' "s/\${db_user}/${MYSQL_USERNAME}/g" /var/www/mysql_init.sql \
    && sed -i'' "s/\${db_password}/${MYSQL_PASSWORD}/g" /var/www/mysql_init.sql

# Configure PHP
RUN set -eux \
	&& { \
		echo "allow_url_include = on"; \
		echo "allow_url_fopen   = on"; \
		echo "error_reporting   = E_ALL | E_STRICT"; \
		echo "magic_quotes_gpc  = off"; \
        echo "log_errors        = on"; \
        echo "error_log         = /var/log/apache2/php-error.log"; \
	} > /usr/local/etc/php/conf.d/default.ini

# Adjust permissions
RUN set -eux \
	&& chown -R www-data:www-data /var/www/html \
    && chmod +x /entrypoint.sh \
	&& chmod 0775 /var/www/html/config/ \
	&& chmod 0775 /var/www/html/hackable/uploads/ \
    && mkdir -p /var/www/html/external/phpids/0.6/lib/IDS/tmp/ \
	&& chmod 0775 /var/www/html/external/phpids/0.6/lib/IDS/tmp/ \
    && touch /var/www/html/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt \
	&& chmod 0664 /var/www/html/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt

expose 80
CMD ["/entrypoint.sh"]