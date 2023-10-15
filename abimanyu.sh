echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install nginx php php-fpm -y
apt-get install lynx apache2 wget unzip -y
service nginx start
service apache2 start

mkdir /var/www/jarkom

php="
<?php
echo 'Halo, Abimanyu';
?>
"
echo "$php" > /var/www/jarkom/index.php

conf_server="
server {

    listen 8002;

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

#ini buat nomor 11 12
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1a4V23hwK9S7hQEDEcv9FL14UkkrHc-Zc' -O /var/www/abimanyu

unzip /var/www/abimanyu -d /var/www/abimanyu.it03

rm /var/www/abimanyu

mv /var/www/abimanyu.it03/abimanyu.yyy.com/* /var/www/abimanyu.it03

rmdir /var/www/abimanyu.it03/abimanyu.yyy.com

abimanyu_conf="<VirtualHost *:80>
    ServerName abimanyu.it03.com
    ServerAlias 10.65.4.3
    ServerAlias www.abimanyu.it03.com
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/abimanyu.it03

    <Directory /var/www/abimanyu-it03>
        Options +Indexes
    </Directory>

    Alias "/home" "/var/www/abimanyu.it03/home.html"
    Alias / /var/www/abimanyu.it03/home.html

    RewriteEngine On

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
" 

echo "$abimanyu_conf" > /etc/apache2/sites-available/abimanyu.it03.conf

#ini buat nomor 13 14 15 16
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1LdbYntiYVF_NVNgJis1GLCLPEGyIOreS' -O /var/www/parikesit

unzip /var/www/parikesit -d /var/www/parikesit.abimanyu.it03

rm /var/www/parikesit

mv /var/www/parikesit.abimanyu.it03/parikesit.abimanyu.yyy.com/* /var/www/parikesit.abimanyu.it03

rmdir /var/www/parikesit.abimanyu.it03/parikesit.abimanyu.yyy.com

parikesit_conf="<VirtualHost *:80>
    ServerName parikesit.abimanyu.it03.com
    ServerAlias www.parikesit.abimanyu.it03.com
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/parikesit.abimanyu.it03

    <Directory /var/www/parikesit.abimanyu.it03/public>
        Options +Indexes
    </Directory>

    <Directory /var/www/parikesit.abimanyu.it03/secret>
        Options -Indexes
    </Directory>

    ErrorDocument 404 /error/404.html
    ErrorDocument 403 /error/403.html

    Alias /js /var/www/parikesit.abimanyu.it03/public/js

    RewriteEngine On

    # Tambahkan aturan RewriteCond untuk mencocokkan permintaan yang mengandung "abimanyu"
    RewriteCond %{REQUEST_URI} abimanyu [NC]

    # Terapkan aturan RewriteRule untuk mengarahkan permintaan ke /public/images/abimanyu.png
    RewriteRule (.*) /public/images/abimanyu.png [L]

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

" 

echo "$parikesit_conf" > /etc/apache2/sites-available/parikesit.abimanyu.it03.conf

#nomor 17 18 19
wget --no-check-certificate 'https://drive.google.com/u/0/uc?id=1pPSP7yIR05JhSFG67RVzgkb-VcW9vQO6&export=download' -O /var/www/rjp

unzip /var/www/rjp -d /var/www/rjp.baratayuda.abimanyu.it03

rm /var/www/rjp

mv /var/www/rjp.baratayuda.abimanyu.it03/rjp.baratayuda.abimanyu.yyy.com/* /var/www/rjp.baratayuda.abimanyu.it03

rmdir /var/www/rjp.baratayuda.abimanyu.it03/rjp.baratayuda.abimanyu.yyy.com

rjp_conf="<VirtualHost *:14000 *:14400>
    ServerName rjp.baratayuda.abimanyu.it03.com
    ServerAlias www.rjp.baratayuda.abimanyu.it03.com
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/rjp.baratayuda.abimanyu.it03

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    <Directory "/var/www/rjp.baratayuda.abimanyu.it03">
        Options +FollowSymLinks -Multiviews
        AllowOverride All
        AuthType Basic
        AuthName "Restricted Content"
        AuthUserFile /etc/apache2/.htpasswd
        Require valid-user
    </Directory>
</VirtualHost>
" 

echo "$rjp_conf" > /etc/apache2/sites-available/rjp.baratayuda.abimanyu.it03.conf

rm /etc/apache2/ports.conf

ports_conf=" '# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 80
Listen 14000
Listen 14400

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
" 
echo "$ports_conf" > /etc/apache2/ports.conf

service nginx restart

service php7.0-fpm start
service php7.0-fpm status

a2enmod rewrite
a2ensite /etc/apache2/sites-available/abimanyu.it03.conf
service apache2 reload
service apache2 start
service apache2 status
