FROM php:7.4-fpm-alpine

COPY --from=composer /usr/bin/composer /usr/bin/composer

# Copy php配置文件
COPY conf.d/php_dev.ini /usr/local/etc/php/conf.d
COPY fpm-conf.d/fpm_dev.conf /usr/local/etc/php-fpm.d

# Copy 镜像初始化文件
COPY docker-laravel-entrypoint.sh /usr/local/bin

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories && \
    apk upgrade && \
    apk update && \
    echo "YES" | apk add gcc g++ pkgconf git zip m4 autoconf imagemagick imagemagick-dev automake make && \
    pecl install imagick  redis  && \
    docker-php-ext-install bcmath pdo_mysql && \
    docker-php-ext-enable imagick redis && \
    apk del --purge --progress && \
    chmod +x /usr/local/bin/docker-laravel-entrypoint.sh

ENTRYPOINT ["docker-laravel-entrypoint.sh"]