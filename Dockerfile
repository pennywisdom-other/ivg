FROM php:7.1.12-fpm-jessie

MAINTAINER Alex H<aliixx@gmail.com>

# install git client
RUN apt-get -y update && apt-get install -y git

# install php extensions for Phalcon ​3.2.3 XDebug
ENV PHALCON_VER 3.2.3
RUN cd /tmp &&\
	curl -sSLO https://codeload.github.com/phalcon/cphalcon/tar.gz/v$PHALCON_VER && \
	tar zxvf v$PHALCON_VER  && \
	cd cphalcon-$PHALCON_VER/build && \
	./install && \
	echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/phalcon.ini && \
  rm -rf /tmp/*

# install xdebug
RUN pecl install xdebug && \
  echo "zend_extension=xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini

# install mongod driver for php
RUN apt-get install -y libcurl4-openssl-dev libssl-dev && \
  pecl install mongodb && \
  touch  /usr/local/etc/php/conf.d/30-mongodb.ini && \
  echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/30-mongodb.ini

# install redis driver for php
RUN pecl install redis && \
  touch  /usr/local/etc/php/conf.d/40-redis.ini && \
  echo "extension=redis.so" > /usr/local/etc/php/conf.d/40-redis.ini

# install composer 1.5.5 is newest release at time of writing, allow super user for install purposes
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /opt/composer
ENV COMPOSER_VERSION 1.5.5

RUN mkdir -p ${COMPOSER_HOME} && \
  curl -s -f -L -o ${COMPOSER_HOME}/installer.php https://raw.githubusercontent.com/composer/getcomposer.org/master/web/installer && \
  php ${COMPOSER_HOME}/installer.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION} && \
  composer --ansi --version --no-interaction

# install nodejs 9 for npm
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
  apt-get install -y nodejs && \
  apt-get install -y build-essential && \
  npm -v

# tidy up everything in image to reduce image size etc
RUN apt-get autoremove -y && \
	apt-get autoclean -y && \
	apt-get clean -y && \
  rm -rf /tmp/*

#RUN php -i

EXPOSE 9000
CMD ["php-fpm"]
