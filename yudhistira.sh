echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install bind9 -y

conf="
zone \"arjuna.it03.com\" {
	type master;
	notify yes;
	also-notify { 10.65.2.2; }; #IP Werkudara
	allow-transfer { 10.65.2.2; };
	file \"/etc/bind/jarkom/arjuna.it03.com\"
};

zone \"abimanyu.it03.com\" {
	type master;
	notify yes;
	also-notify { 10.65.2.2; }; #IP Werkudara
	allow-transfer { 10.65.2.2; };
	file \"/etc/bind/jarkom/abimanyu.it03.com\"
};

zone \"4.65.10.in-addr.arpa\" {
	type master;
	file \"/etc/bind/jarkom/4.65.10.in-addr.arpa\";
};

zone "baratayuda.abimanyu.it03.com" {
	type master;
	file "/etc/bind/jarkom/baratayuda.abimanyu.it03.com";
	allow-transfer { 10.65.2.2; }; #IP Werkudara
};
"
echo "$conf" > /etc/bind/named.conf.local

mkdir /etc/bind/jarkom

cp /etc/bind/db.local /etc/bind/jarkom/arjuna.it03.com

arjuna="
;
;BIND data file for local loopback interface
;
\$TTL    604800
@    IN    SOA    arjuna.it03.com. root.arjuna.it03.com. (
            2       ; Serial
                    604800          ; Refresh
                    86400           ; Retry
                    2419200         ; Expire
                    604800 )        ; Negative Cache TTL
;                   
@    IN    NS    arjuna.it03.com.   
@    IN    A    10.65.4.5           ; IP Arjuna
"
echo "$arjuna" > /etc/bind/jarkom/arjuna.it03.com

cp /etc/bind/db.local /etc/bind/jarkom/abimanyu.it03.com

abimanyu="
;
;BIND data file for local loopback interface
;
\$TTL    604800
@    IN    SOA    abimanyu.it03.com. root.abimanyu.it03.com. (
            2       ; Serial
                    604800          ; Refresh
                    86400           ; Retry
                    2419200         ; Expire
                    604800 )        ; Negative Cache TTL
;                   
@    IN    NS       abimanyu.it03.com.  
@    IN    A        10.65.4.3           ; IP Abimanyu
www	 IN	   CNAME	abimanyu.it03.com
parikesit       IN	A	10.65.4.3       ; IP Abimanyu
www.parikesit   IN  A   10.65.4.3 
"
echo "$abimanyu" > /etc/bind/jarkom/abimanyu.it03.com

cp /etc/bind/db.local /etc/bind/jarkom/4.65.10.in-addr.arpa

reverse="
;
;BIND data file for local loopback interface
;
\$TTL    604800
@    IN    SOA    abimanyu.it03.com. root.abimanyu.it03.com. (
            2       ; Serial
                    604800          ; Refresh
                    86400           ; Retry
                    2419200         ; Expire
                    604800 )        ; Negative Cache TTL
;                   
@    IN   NS   abimanyu.it03.com.
3    IN   PTR  abimanyu.it03.com.
"
echo "$reverse" > /etc/bind/jarkom/4.65.10.in-addr.arpa

cp /etc/bind/db.local /etc/bind/jarkom/baratayuda.abimanyu.it03.com

baratayuda="
;
;BIND data file for local loopback interface
;
\$TTL    604800
@    IN    SOA    baratayuda.abimanyu.it03.com. root.baratayuda.abimanyu.it03.com. (
            2       ; Serial
                    604800          ; Refresh
                    86400           ; Retry
                    2419200         ; Expire
                    604800 )        ; Negative Cache TTL
;                   
@	IN	NS	baratayuda.abimanyu.it03.com.
@	IN	A	10.65.4.3   ; IP Abimanyu
www	IN	CNAME baratayuda.abimanyu.it03.com.
ns1	IN	A	10.65.2.2   ; IP Werkudara
baratayuda	IN	NS	ns1
"
echo "$baratayuda" > /etc/bind/jarkom/baratayuda.abimanyu.it03.com

service bind9 restart
