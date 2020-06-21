#!/bin/sh

if [[ ${PROJECT_CREATE}="true" && "`ls -A ${PROJECT_NAME}`" = "" ]]; then
    composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
    composer create-project --prefer-dist laravel/laravel ${PROJECT_NAME}
fi

exec "php-fpm"