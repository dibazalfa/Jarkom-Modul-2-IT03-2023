echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install bind9 -y

conf="
zone "arjuna.it03.com" {
	type slave;
	masters { 10.65.1.2; }; #IP  Yudhistira
	file "/var/lib/bind/arjuna.it03.com";
};
zone "abimanyu.it03.com" {
	type slave;
	masters { 10.65.1.2; }; #IP  Yudhistira
	file "/var/lib/bind/abimanyu.it03.com";
};
zone "baratayuda.abimanyu.it03.com" {
	type master;
	file "/etc/bind/delegasi/baratayuda.abimanyu.it03.com";
};
zone "rjp.baratayuda.abimanyu.it03.com" {
	type master;
	file "/etc/bind/jarkom/rjp.baratayuda.abimanyu.it03.com";
};
"
echo "$conf" > /etc/bind/named.conf.local

mkdir /etc/bind/delegasi

cp /etc/bind/db.local /etc/bind/delegasi/baratayuda.abimanyu.it03.com

baratayuda="
;
;BIND data file for local loopback interface
;
\$TTL    604800
@    IN    SOA    baratayuda.abimanyu.it03.com. root.baratayuda.abimanyu.it03.com. (
        2        ; Serial
                604800        ; Refresh
                86400        ; Retry
                2419200        ; Expire
                604800 )    ; Negative Cache TTL
;                   
@	IN	NS	baratayuda.abimanyu.it03.com.
@	IN	A	10.65.4.3
www	IN	A	10.65.4.3
"
echo "$baratayuda" > /etc/bind/delegasi/baratayuda.abimanyu.it03.com

mkdir /etc/bind/jarkom

cp /etc/bind/db.local /etc/bind/jarkom/rjp.baratayuda.abimanyu.it03.com

rjp="
;
;BIND data file for local loopback interface
;
\$TTL    604800
@    IN    SOA    rjp.baratayuda.abimanyu.it03.com. root.rjp.baratayuda.abimanyu.it03.com. (
        2        ; Serial
                604800        ; Refresh
                86400        ; Retry
                2419200        ; Expire
                604800 )    ; Negative Cache TTL
;                   
@	IN	NS	rjp.baratayuda.abimanyu.it03.com.
@	IN	A	10.65.4.3
www	IN	A	10.65.4.3
"
echo "$rjp" > /etc/bind/jarkom/rjp.baratayuda.abimanyu.it03.com

service bind9 restart
