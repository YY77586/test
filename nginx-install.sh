#!/bin/bash
#nginx一键安装脚本，编写nginx-1.18.0.tar.gz

#使用yum安装zlib、pcre、openssl 等软件包
yum install  -y gcc  zlib zlib-devel  pcre pcre-devel openssl openssl-devel &>/dev/null
#添加 Nginx 用户
groupadd  -g 88 nginx
useradd  -g nginx -M -s /sbin/nologin -u 88 nginx


#解压：nginx-1.18.0.tar.gz，编译参数如下
cd /opt/
wget  http://192.168.200.5/package/nginx-1.18.0.tar.gz
tar -xf nginx-1.18.0.tar.gz
cd nginx-1.18.0
./configure --user=nginx  --group=nginx --prefix=/usr/local/nginx --with-http_stub_status_module  --with-http_sub_module  --with-http_ssl_module  --with-pcre &>/dev/null
make && make install &>/dev/null
#启动服务：
/usr/local/nginx/sbin/nginx
sleep 2
if ! [  -z   `netstat  -anplt | grep :80 | head -1 | grep LISTEN` ]&>/dev/null
then
    echo "nginx 启动成功。"
else
    echo "nginx 启动失败。"
fi
ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/
cp /usr/local/nginx/conf/nginx.conf  /usr/local/nginx/conf/nginx.conf.bak
mkdir /usr/local/nginx/conf.d/





