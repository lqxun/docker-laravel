#!/bin/sh

PHPINFO_EXISTS=`ls -A | grep phpinfo.php`
FILE_COUNT=`ls -A | wc -l`

if [[ ${PROJECT_CREATE}="true" ]]; then

    if [[ ${FILE_COUNT} = 0 || (${FILE_COUNT} = 1 && ${PHPINFO_EXISTS}) ]]; then
        `rm -rf *`
        composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
        composer create-project --prefer-dist laravel/laravel ${PROJECT_NAME}
        echo "<?php phpinfo();" > phpinfo.php
    fi
fi


PHPINFO_EXISTS=`ls -A | grep phpinfo.php`

if [[ -z ${PHPINFO_EXISTS} ]]; then
    echo "<?php phpinfo();" > phpinfo.php
fi

exec "php-fpm"