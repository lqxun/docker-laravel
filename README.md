## Docker Laravel

### 概述
  在实际工作中，你可能会有这样的尴尬，电脑系统不敢升级，升级后所有环境得重新搭建，浪费不必要的时间。这个项目旨在从0跑起来一个Laravel项目，只需要一个简单的命令，如果你是一个Laravel新手，你甚至都不需要执行```composer create-project```来创建Laravel，下面的一个命令会为你准备好一切。

```docker
// 构建并启动环境，启动后可通过http://${NGINX_HOST}:8888访问,NGINX_HOST在nginx下.env文件中定义
docker-compose up 
```
效果如下

![docker laravel](https://cdn.learnku.com/uploads/images/202006/21/11945/94RAmtcHt1.png!large)

或者

![docker Laravel](https://cdn.learnku.com/uploads/images/202006/21/11945/FKdBmBMMbS.png!large)


如果不需要创建新的Larave项目，只想要一个能跑起来的环境，你只需要更改根目录下```common.env```中的```PROJECT_CREATE=false```，然后把你的项目拷贝`src`目录中即可。如果你想尽快试试，地址在这里：[github](https://github.com/lqxun/docker-laravel)

### 启动方式
```git
// 访问http://127.0.0.1:8888
git clone git@github.com:lqxun/docker-laravel.git
cd docker-laravel
docker-compose up
```

### 项目配置
##### 1、公共配置
公共配置在根目录下的`common.env`文件中，里面定义了如下内容
*注：需要创建新项目时会以该配置创建项目目录
```.env
# 是否重新创建项目（composer create）
PROJECT_CREATE=true
#项目名称（project下的文件夹名，nginx 的root会指向${PROJECT_NAME}/public）
PROJECT_NAME=blog

# 时区
TZ=Asia/Shanghai
```

##### 2、配置Nginx域名和项目目录
`nginx`目录中有`.env`文件
```.env
# 端口号
NGINX_PORT=80
# 访问域名（记得修改host）
NGINX_HOST=test.doc
```
配置文件定义在`nginx/templates`目录下以`*.template`结尾的文件中，该文件中可直接读取`.env`配置的环境变量，该文件最终会被输出到`/etc/nginx/conf.d`目录下。附上`nginx`官方镜像文档[传送门](https://hub.docker.com/_/nginx/?tab=description)

##### 3、配置PHP
目录结构如下
```
├── .env
├── Dockerfile
├── conf.d
│   └── php_dev.ini
├── docker-laravel-entrypoint.sh
└── fpm-conf.d
    └── fpm_dev.conf
```
`php`目录预留了`.env`文件，默认是空的，如有需要可自行定义`conf.d`,目录下定义了`php`配置文件`php_dev.ini`，`fpm-conf.d`下定义了`fpm`配置文件`fpm_dev.conf`可自行修改。`php`扩展的安装，请参考官方镜像文档[传送门](https://hub.docker.com/_/php)
> `php`的配置文件可以`volume`挂载进去，也可以在`Dockerfile`中`COPY`进去，但是有个问题：如果挂载进去，本地的配置会覆盖容器中的配置，可能会删除一些默认配置，好处是，不需要重新构建镜像，只需要重启镜像即可。如果`COPY`进去，不会破坏容器默认的配置，但是每次都需要重新构建镜像，看大家需要自行选择吧。本项目是`COPY`进去的。挂载的代码也已写好，只需打开`docker-compose.yml`中的注视，把`Dockerfile`中`COPY`注视掉即可。

##### 4、Mysql配置
`mysql`的`my.cnf`是挂载到容器中的，,更改配置只需要重启容器即可,l连接端口`33060`，密码在`mysql`文件夹下的`.env`中配置。如果出现一下问题

![docker Laravel](https://cdn.learnku.com/uploads/images/202006/21/11945/wSYiyfugR0.png!large)

这是客户端问题，请换个客户端。如果不想换客户端，可按照资料自行修改即可附连接[Docker容器中SQLyog连接数据库报错plugin caching_sha2_password](https://blog.csdn.net/weixin_43935079/article/details/85720814)
