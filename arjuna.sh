echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install nginx -y

nginx_arjuna="http {
	upstream nodes_lb {
	server 10.65.4.2:8001;
server 10.65.4.3:8002;
server 10.65.4.4:8003;
}
}
server {
	listen 80;
	listen [::]:80;

	server_name arjuna.it03.com;

	location / {
		proxy_pass http://nodes_lb;
		proxy_set_header Host $host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
}
}" 

echo "$nginx_arjuna" > /etc/nginx/sites-available/arjuna.it03.com

nginx_conf="user www-data
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
	worker_connections 768;
	#multi_accept on
}

http {
	upstream nodes_lb {
		server 10.65.4.2:8001;
        server 10.65.4.3:8002;
        server 10.65.4.4:8003;
    }

    server {
	    listen 80;
	    listen [::]:80;

	    server_name arjuna.it03.com;

        location / {
            proxy_pass http://nodes_lb;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
    }
}" 

echo "$nginx_conf" > /etc/nginx/nginx.conf

ln -s /etc/nginx/sites-available/arjuna.it03.com	/etc/nginx/sites-enabled/arjuna.it03.com

rm /etc/nginx/sites-enabled/arjuna.it03.com

service nginx restart
