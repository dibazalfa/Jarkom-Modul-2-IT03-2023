echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install nginx php php-fpm -y
apt-get install lynx -y
service nginx start

mkdir /var/www/jarkom

php="
<?php
echo 'Halo, Prabukusuma';
?>
"
echo "$php" > /var/www/jarkom/index.php

conf_server="
server {

    listen 8001;

    root /var/www/jarkom;

    index index.php index.html index.htm;
    server_name _;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    # pass PHP scripts to FastCGI server
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }

    error_log /var/log/nginx/jarkom_error.log;
    access_log /var/log/nginx/jarkom_access.log;
}
"
echo "$conf_server" > /etc/nginx/sites-available/jarkom

ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled

rm /etc/nginx/sites-enabled/default

service nginx restart

service php7.0-fpm start
service php7.0-fpm status
