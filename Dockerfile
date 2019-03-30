FROM php:7.2.16-cli-alpine3.9

# 使用阿里镜像
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache --update zlib $PHPIZE_DEPS

RUN docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install opcache

COPY conf.d/opcache.ini $PHP_INI_DIR/conf.d/

RUN pecl install redis-4.0.1 \
    && pecl install swoole-4.3.1 \
    && docker-php-ext-enable redis swoole

RUN rm -rf /tmp/pear