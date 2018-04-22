FROM ubuntu:16.04

RUN apt update -yqq && apt install -yqq software-properties-common
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt update -yqq
RUN apt install -yqq nginx git unzip php5.6 php5.6-common php5.6-cli php5.6-fpm php5.6-mysql

COPY deploy/conf/* /etc/php/5.6/fpm/
RUN sed -i "s|listen = /run/php/php7.2-fpm.sock|listen = /run/php/php5.6-fpm.sock|g" /etc/php/5.6/fpm/php-fpm.conf

ADD ./ /php
WORKDIR /php

RUN chmod -R 777 /php

CMD service php5.6-fpm start && \
    nginx -c /php/deploy/nginx5.conf -g "daemon off;"