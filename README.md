# Jarkom-Modul-2-IT03-2023

## Kelompok: IT03
### Anggota: 
Nama | NRP | Github 
--- | --- | --- |
Adiba Zalfa Camilla | 5027211060 | https://github.com/dibazalfa
Wiridlangit Suluh Jiwangga | 5027211064 | https://github.com/wiridlangit

## Daftar isi
- [Konfigurasi](#konfigurasi)
- [Nomor 1](#nomor-1)
- [Nomor 2](#nomor-2)
- [Nomor 3](#nomor-3)
- [Nomor 4](#nomor-4-subdomain)
- [Nomor 5](#nomor-5-reverse-dns)
- [Nomor 6](#nomor-6-dns-slave)
- [Nomor 7](#nomor-7)
- [Nomor 8](#nomor-8)
- [Nomor 9](#nomor-9)
- [Nomor 10](#nomor-10)
- [Nomor 11](#nomor-11)
- [Nomor 12](#nomor-12)
- [Nomor 13](#nomor-13)
- [Nomor 14](#nomor-14)
- [Nomor 15](#nomor-15)
- [Nomor 16](#nomor-16)
- [Nomor 17](#nomor-17)
- [Nomor 18](#nomor-18)
- [Nomor 19](#nomor-19)
- [Nomor 20](#nomor-20)
# Konfigurasi
1. Masukkan `iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.65.0.0/16` pada node **Pandudewanata**. (10.65 adalah prefix yang ditentukan untuk kelompok IT03)
2. Masukkan `echo nameserver 192.168.122.1 > /etc/resolv.conf` pada semua node.
3. Install bind9 pada node **Yudhistira** dan **Werkudara**.
	Berikut langkah instalasi bind9:
	1. `apt-get update`
	2. `apt-get install bind9`
 4. Install nginx pada node Arjuna-LB
    	Berikut langkah instalasi nginx:
    	1. `apt-get update`
	2. `apt-get install nginx -y`
    	
# Nomor 1
Menggunakan Topologi ke-3 pada drive yang telah disediakan. Lalu masukan konfigurasi network pada setiap node.

DNS Master = Yudhistira

DNS Slave = Werkudara
Load Balancer = Arjuna

Web Server = Prabukusuma, Abimanyu, Wisanggeni

Client = Sadewa, Nakula

![Screenshot 2023-10-15 140006](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/19817d4b-cd04-4822-812c-272e67d0eb4b)

## Pandudewanata
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 10.65.1.1
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 10.65.2.1
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 10.65.3.1
	netmask 255.255.255.0

auto eth4
iface eth4 inet static
	address 10.65.4.1
	netmask 255.255.255.0

```

## Yudhistira
```
auto eth0
iface eth0 inet static
	address 10.65.1.2
	netmask 255.255.255.0
	gateway 10.65.1.1
```

## Werkudara
```auto eth0
iface eth0 inet static
	address 10.65.2.2
	netmask 255.255.255.0
	gateway 10.65.2.1
```

## Sadewa
```auto eth0
iface eth0 inet static
	address 10.65.3.2
	netmask 255.255.255.0
	gateway 10.65.3.1
```

## Nakula
```auto eth0
iface eth0 inet static
	address 10.65.3.3
	netmask 255.255.255.0
	gateway 10.65.3.1
```

## Arjuna-LB
```auto eth0
iface eth0 inet static
	address 10.65.4.5
	netmask 255.255.255.0
	gateway 10.65.4.1
```

## Prabukusuma
```auto eth0
iface eth0 inet static
	address 10.65.4.2
	netmask 255.255.255.0
	gateway 10.65.4.1
```

## Abimanyu
```auto eth0
iface eth0 inet static
	address 10.65.4.3
	netmask 255.255.255.0
	gateway 10.65.4.1
```

## Wisanggeni
```auto eth0
iface eth0 inet static
	address 10.65.4.4
	netmask 255.255.255.0
	gateway 10.65.4.1
```

# Nomor 2
Membuat website utama pada node arjuna dengan akses ke arjuna.it03.com dengan alias www.arjuna.it03.com
Ditentukan Yudhistira sebagai DNS Master dan Sadewa sebagai client.
## Yudhistira
### /etc/bind/named.conf.local
```
zone “arjuna.it03.com” {
	type master;
	file “/etc/bind/jarkom/arjuna.it03.com
};
```
Lalu buat folder baru bernama `jarkom` lalu setelah itu gunakan command `cp /etc/bind/db.local /etc/bind/jarkom/arjuna.it03.com` pada terminal untuk membuat file `arjuna.it03.com`.

### /etc/bind/jarkom/arjuna.it03.com
![image12](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/460f3244-a35e-42a1-9148-8b7c08e029a9)


diakhiri dengan command `service bind9 restart`.

## Sadewa
### /etc/resolv.conf
`nameserver 10.65.1.2`

setelah mengganti nameserver pada ip yang sesuai masukkan command `nslookup arjuna.it03.com` atau `nslookup www.arjuna.it03.com`. (command `ping` juga bisa digunakan untuk mengganti `nslookup`)

Output jika berhasil akan terlihat seperti ini:
![image22](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/63343d06-53dc-455c-941d-dd4d30fdce32)


![image16](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/dd48beb5-a66c-431d-8257-fa268fb63213)


# Nomor 3
Membuat website utama pada node arjuna dengan akses ke abimanyu.it03.com dengan alias www.abimanyu.it03.com
## Yudhistira
### /etc/bind/named.conf.local
```
zone “abimanyu.it03.com” {
	type master;
	file “/etc/bind/jarkom/abimanyu.it03.com
};
```

### /etc/bind/jarkom/abimanyu.it03.com
![image21](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/aa4f813a-479d-45a6-a5d5-0979fdbd4fd3)

diakhiri dengan command `service bind9 restart`.

## Sadewa
Masukkan command `nslookup abimanyu.it03.com` atau `nslookup www.abimanyu.it03.com`. (command `ping` juga bisa digunakan untuk mengganti `nslookup`)

![](https://cdn.discordapp.com/attachments/955087631224537088/1163427001739264041/image.png?ex=653f88d4&is=652d13d4&hm=ffff79caabd9f3c6eb5bc23509cc222d9afe9052948d9a775b0b2e34a8c89c85&)

![](https://media.discordapp.net/attachments/955087631224537088/1163427062665719890/image.png?ex=653f88e3&is=652d13e3&hm=e061e2237c382d12bc985cb7806a06f76e8561f153fc5d5b3180f09ff9841506&=&width=1440&height=303)

# Nomor 4 (subdomain)
Membuat subdomain pada parikesit.abimanyu.it03.com yang mengarah ke `abimanyu`
## Yudhistira
### /etc/bind/jarkom/abimanyu.it03.com
Tambah konfigruasi `parikesit	IN	A		10.65.4.3 #IP Abimanyu`
![image3](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/7b9c9801-9862-47ad-9a94-0b6f5888aa60)


## Sadewa
Gunakan `nslookup parikesit.abimanyu.it03.com` untuk melihat output.
![image9](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/b5e7dc86-3d8e-43ce-993e-127485378e5c)


# Nomor 5 (reverse dns)
Membuat reverse domain untuk domain utama (hanya abimanyu yg di reverse)
## Yudhistira
Tambahkan konfigurasi berikut:
### /etc/bind/named.conf.local

```
zone “4.65.10.in-addr.arpa” {
	type master;
	file “/etc/bind/jarkom/4.65.10-in.addr.arpa”;
};
```

lalu masukkan command `cp /etc/bind/db.local /etc/bind/jarkom/4.65.10.in-addr.arpa` pada terminal.

## /etc/bind/jarkom/4.65.10.in-addr.arpa
![image34](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/c34042be-0b06-40d1-9c0b-90d58bb5a969)

diakhiri dengan `service bind9 restart`

## Sadewa
Gunakan command `host -t PTR 10.65.4.3` untuk mengetahui apakah sudah berhasil atau tidak.
![image5](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/0ff112eb-e18d-4c6c-a57c-4bfdb7b723d9)


# Nomor 6 (dns slave)
Membuat werkudara sebagai DNS Slave agar tetap dapat dihubungi ketika Yudhistira bermasalah
Tambahkan konfigruasi 
## Yudhistira
```
zone “arjuna.it03.com” {
	type master;
	notify yes;
	also-notify { 10.65.2.2; }; #IP Werkudara
	allow-transfer { 10.65.2.2; };
	file “/etc/bind/jarkom/arjuna.it03.com”
};
zone “abimanyu.it03.com” {
	type master;
	notify yes;
	also-notify { 10.65.2.2; }; #IP Werkudara
	allow-transfer { 10.65.2.2; };
	file “/etc/bind/jarkom/abimanyu.it03.com”
};
```

lalu dilanjutkan `service bind9 restart`

## Werkudara
Tambahkan konfigruasi
```
zone “arjuna.it03.com” {
	type slave;
	masters { 10.65.1.2; }; #IP  Yudhistira
	file “/var/lib/bind/arjuna.it03.com”;
};
zone “abimanyu.it03.com” {
	type slave;
	masters { 10.65.1.2; }; #IP  Yudhistira
	file “/var/lib/bind/abimanyu.it03.com”;
};
```

lalu dilanjutkan `service bind9 restart`

## Yudhistira
`service bind9 stop`
![image7](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/0b6df642-1987-41e3-a548-db810dd8d83c)


## Sadewa
### /etc/resolv.conf
`nameserver 10.65.2.2`

ping arjuna.it03.com -c 5
![image1](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/8e28ceab-377d-4e7e-8f87-83b67734af27)


ping abimanyu.it03.com -c 5
![image25](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/7c2032f0-c86d-4b3f-ac72-b6611f386d6c)

# Nomor 7
Membuat subdomain khusus untuk perang yaitu baratayuda.abimanyu.it03.com dengan alias www.baratayuda.abimanyu.it03.com yang didelegasikan dari Yudhistira ke Werkudara 
## Yudhistira
Atur konfigurasi sesuai seperti dibawah:
### /etc/bind/jarkom/baratayuda.abimanyu.it03.com
![image13](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/2e8066d4-5a59-487d-aec8-3f01d41dffd3)
### /etc/bind/named.conf.options
![image29](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/4764b03a-c9bf-40bb-a5d2-b18166beb4d3)
### /etc/bind/named.conf.local
![](https://cdn.discordapp.com/attachments/955087631224537088/1163428198634242118/image.png?ex=653f89f2&is=652d14f2&hm=641459c7616e2b3c3225af2035e4176db385d80b74f51137689ff64599b3937f&)

`service bind9 restart`

# Werkudara
Atur konfigurasi sesuai seperti dibawah:
### /etc/bind/named.conf.options
![image29](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/97ee0450-c4d3-4371-88bf-b66c57d344f6)

### /etc/bind/named.conf.local
![image27](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/948c5309-5f0a-4793-a431-69fb0652479c)

Buat folder `/etc/bind/delegasi` lalu tuliskan command `cp /etc/bind/db.local /etc/bind/delegasi/baratayuda.abimanyu.it03.com`

### /etc/bind/delegasi/baratayuda.abimanyu.it03.com
![image30](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/50d11da2-4071-4ce5-9e1c-55d1c69bfd05)

Diakhiri dengan `service bind9 restart` pada terminal.

# Sadewa
Periksa keberhasilan dengan command `ping baratayuda.abimanyu.it03.com` dan `ping www.baratayuda.abimanyu.it03.com`.

![image28](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/f127a48b-9e2d-49fd-8dab-5f0d37a1cfc7)
![](https://cdn.discordapp.com/attachments/955087631224537088/1163428508287119400/image.png?ex=653f8a3b&is=652d153b&hm=4de15f2e68e572f27fb0ff609da9d907e5c5fd2191ff0881221ac54a2db7f417&)

# Nomor 8
Membuat subdomain melalui werkudara dengan akses rjp.baratayuda.abimanyu.it03.com dengan alias www.rjp.baratayuda.abimanyu.it03.com yang mengarah ke abimanyu
## Werkudara
### /etc/bind/named.conf.local
![image11](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/aa9ce5c7-e648-4d6a-9e51-cdbe7b508243)

Lalu buat folder `mkdir /etc/bind/jarkom` dan tuliskan command `cp /etc/bind/db.local /etc/bind/jarkom/rjp.baratayuda.abimanyu.it03.com` pada terminal.

### /etc/bind/jarkom/rjp.baratayuda.abimanyu.it03.com
![image14](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/8e8ad2c1-ad44-451c-bfef-3fd7f0d68891)

diakhiri dengan `service bind9 restart`.

# Sadewa
Gunakan `ping rjp.baratayuda.abimanyu.it03.com` atau `www.ping rjp.baratayuda.abimanyu.it03.com` untuk melihat keberhasilan konfigurasi.

![image2](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/9dc405db-b756-40ae-aac1-ee7c886e153b)
![](https://media.discordapp.net/attachments/955087631224537088/1163429794231373884/image.png?ex=653f8b6e&is=652d166e&hm=86995bf78f96ef412743e929a21566d9bbfe7bf78fa419e450157452669dcc92&=&width=1228&height=203)

# Nomor 9
Melakukan deployment pada masing-masing worker dengan Arjuna sebagai load balancer
## Worker (Prabukusuma, Abimanyu, Wisanggeni)
### /var/www/jarkom/index.php
![image18](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/c2ed9039-ef67-4409-b5ca-8b44f0817df1)

### /etc/nginx/sites-available/jarkom
![image24](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/29bf321b-9a3b-4724-a3de-72ef88ed2355)

selanjutnya tuliskan command `ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled` dilanjutkan dengan `rm /etc/nginx/sites-enabled/default`.
tuliskan `service nginx restart`.

Lakukan hal yang sama di ketiga worker, bedakan di port dan isi dari website php.

## Sadewa
Pada terminal tuliskan commadn dibawah untuk periksa apakah sudah berhasil:
`lynx http://10.65.4.2:8001`
![image10](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/84606006-c24c-4507-b222-352015d0aab3)

`lynx http://10.65.4.3:8002`
![image31](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/516f2a6d-1679-4be1-bb13-aefc13cd6dfd)

`lynx http://10.65.4.4:8003`
![image32](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/1fc43afc-d1d4-43e9-b514-a369a66c7adb)

# Nomor 10
Menggunakan algoritma roud robin untuk load balancer pada arjuna yang berjalan di port 8001-8003
    - Prabakusuma:8001
    - Abimanyu:8002
    - Wisanggeni:8003
## Arjuna
### /etc/nginx/sites-available/arjuna.it03.com
```
http {
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
}
```
Lakukan konfigurasi pada nginx
### /etc/nginx/nginx.conf
```
user www-data;
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
}

```

lanjut dengan tulis command:
1. `ln -s /etc/nginx/sites-available/arjuna.it03.com /etc/nginx/sites-enabled/arjuna.it03.com`
2. `rm /etc/nginx/sites-enabled/arjuna.it03.com`
3. `service nginx restart`

## Sadewa
`lynx http://www.arjuna.it03.com`

![untitled](https://cdn.discordapp.com/attachments/955087631224537088/1163417251379150928/image.png?ex=653f7fbf&is=652d0abf&hm=30fd7f9c34b2ee7fcd5c89d5e9721b590b282535d58852d67fbfbfaa1ad29eee&)
![untitled](https://cdn.discordapp.com/attachments/955087631224537088/1163417300980994058/image.png?ex=653f7fcb&is=652d0acb&hm=f3c842e988965a9e699b6ce84d28a2982eb0d870dad2af4226d8ebe307806b81&)
![untitled](https://cdn.discordapp.com/attachments/955087631224537088/1163417344920526898/image.png?ex=653f7fd6&is=652d0ad6&hm=209aadf31893086a0f2ce994ac39002238cf4a76b35cab2bd0fc4592d5f16683&)


# Nomor 11
Melakukan konfigurasi Apache Web Server pada worker Abimanyu dengan web server www.abimanyu.it03.com
## Abimanyu
Ikuti command dibawah ini untuk mengunduh resource yang telah diberikan dan memasukkannya ke dalam /var/www/abimanyu.it03:
1. `cd /var/www`
2. `wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1a4V23hwK9S7hQEDEcv9FL14UkkrHc-Zc' -O abimanyu`
3. `unzip abimanyu -d abimanyu.it03`
4. `mv abimanyu.it03/abimanyu.yyy.com/* abimanyu.it03`
5. `rmdir abimanyu.it03/abimanyu.yyy.com`

### /etc/apache2/sites-available/abimanyu.it03.conf
![image17](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/4127a573-1570-445a-a694-fe231901dd4b)

tuliskan `a2ensite abimanyu.it03.conf` pada terminal lalu `service apache2 restart`

## Sadewa
Untuk periksa keberhasilan bisa tuliskan `lynx http://www.abimanyu.it03.com`.

![image27](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/4856e201-6c83-4913-91e7-cfd3d43dabd2)

# Nomor 12
Mengubah agar url www.abimanyu.it03.com/index.php/home menjadi www.abimanyu.it03.com/home
## Abimanyu
### /etc/apache2/sites-available/abimanyu.it03.conf
Tambahkan `Alias "/home" "/var/www/abimanyu.it03/home.html`

![image50](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/b31b60d0-e3f9-4249-ad1d-6a0d0592d098)

## Sadewa
Periksa keberhasilan dengan `lynx http://ww.abimanyu.it03.com/home`.

![image2](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/79d834f8-285c-4b92-961f-d6d23e4805e5)

# Nomor 13
Melakukan konfigurasi Apache Web Server pada subdomain www.parikesit.abimanyu.yyy.com
## Yudhistira
### /etc/bind/jarkom/abimanyu.it03.com
Tambahkan `www.parikesit	IN	A	10.65.4.3`

![image31](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/7b3ef54a-d554-4063-9048-9402440992f3)

## Abimanyu
Ikuti command dibawah ini untuk mengunduh resource yang telah diberikan dan memasukkannya ke dalam /var/www/parikesit.abimanyu.it03:
1. `cd /var/www`
2. `wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1LdbYntiYVF_NVNgJis1GLCLPEGyIOreS' -O parikesit.zip`
3. `unzip parikesit.zip -d parikesit.abimanyu.it03`
4. `mv parikesit.abimanyu.it03/parikesit.abimanyu.yyy.com/* parikesit.abimanyu.it03`
5. `rmdir parikesit.abimanyu.it03/parikesit.abimanyu.yyy.com`
6. `mkdir parikesit.abimanyu.it03/secret`
7. `echo “html bebas” > /parikesit.abimanyu.it03/secret/bebas.html`

### /etc/apache2/sites-available/parikesit.abimanyu.it03.conf

![image39](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/a3df021b-ad05-4bc2-b709-c7f584f202b5)

dilanjutkan deengan `a2ensite parikesit.abimanyu.it03.conf` dan `service apache2 restart`.

## Sadewa
Tuliskan `lynx http://www.parikesit.abimanyu.it03.com` untuk periksa keberhasilan.

![image41](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/1b73c344-6eff-4fcb-a798-7aafdcbed824)

# Nomor 14
Pada www.parikesit.abimanyu.it03.com pada folder /public akan directory listing, pada folder /secret tidak dapat diakses (403 Forbidden)
## Abimanyu
### /etc/apache2/sites-available/parikesit.abimanyu.it03.com
tambahkan code berikut
  ```
<Directory /var/www/parikesit.abimanyu.it03/public>
        Options +Indexes
    </Directory>

<Directory /var/www/parikesit.abimanyu.it03/secret>
        Options -Indexes
    </Directory>
```
Diakhiri dengan `service apache2 restart`.

# Sadewa
Masukan command dibawah untuk periksa keberhasilan:
1. `lynx http://www.parikesit.abimanyu.it03.com/public`
![image40](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/176ef440-52ad-48e6-bc15-e7c567d77db3)

2. `lynx http://www.parikesit.abimanyu.it03.com/secret`
![image20](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/97c80488-9778-454f-b722-a299e85e282f)
![image1](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/bebb824a-9154-4fa8-bf5c-a33b4db805aa)

# Nomor 15
Meng-kustom halaman error pada folder /error untuk mengganti error kode pada Apache
## Abimanyu
### /etc/apache2/sites-available/parikesit.abimanyu.it03.conf 
Tambahkan code berikut:
```
ErrorDocument 404 /error/404.html
ErrorDocument 403 /error/403.html
```
Diakhiri dengan `service apache2 restart`

## Sadewa
Masukan command dibawah untuk periksa keberhasilan:
1. `lynx http://parikesit.abimanyu.it03.com/halo`
`custom 404 not found`
![image12](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/6efd2c90-e91f-48fb-b6a6-390946eee781)

2. `lynx http://parikesit.abimanyu.it03.com/secret`
`custom 403 forbidden`
![image3](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/11fa87af-c288-4d9b-bfcf-2048c6eaa0e2)

# Nomor 16
Mengkonfigurasi agar www.parikesit.abimanyu.it03.com/public/js menjadi www.parikesit.abimanyu.it03.com/js
## Abimanyu
### /etc/sites-available/parikesit.abimanyu.it03.conf
Tambahkan code berikut:
`Alias /js /var/www/parikesit.abimanyu.it03/public/js`

## Sadewa
Masukan command dibawah untuk periksa keberhasilan:
`lynx http://www.parikesit.abimanyu.it03.com/js`
![image33](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/4cf659f6-5a14-46cc-97d4-cbef497c6be4)

# Nomor 17
Mengkonfigurasi agar www.rjp.baratayuda.abimanyu.it03.com agar hanya dapat diakses melalui port 14000 dan 14400
## Abimanyu
download resources rjp yang diberikan ke dalam /var/www dengan cara yang sama seperti soal sebelumnya.
### /etc/apache2/sites-available/rjp.baratayuda.abimanyu.it03.conf
![image34](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/02c918c1-4975-4821-ada4-e76956f8baec)

## Sadewa
Masukan command dibawah untuk periksa keberhasilan:
1. `lynx http://www.rjp.baratayuda.abimanyu.it03.com`
![image23](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/bf7948e6-1e9a-4b72-8883-79e4c03f0c13)

2. `lynx http://www.rjp.baratayuda.abimanyu.it03.com:14000`
3. `lynx http://www.rjp.baratayuda.abimanyu.it03.com:14400`
![image20](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/3051bb71-ec84-4c2b-bd17-52dabf8d57c7)

# Nomor 18
Membuat authentikasi username berupa "Wayang" dan password "baratayudait03" untuk mengakses www.rjp.baratayuda.it03.com
## /etc/apache2/sites-available/rjp.baratayuda.abimanyu.it03.com
Tambahkan konfigurasi:
```
<Directory "/var/www/rjp.baratayuda.abimanyu.it03">
        Options +FollowSymLinks -Multiviews
        AllowOverride All
        AuthType Basic
        AuthName "Restricted Content"
        AuthUserFile /etc/apache2/.htpasswd
        Require valid-user
    </Directory>
```
Lanjutkan mengikuti langkah dibawah:
1. `cd /etc/apache2/sites-available/`
2. `htpasswd -c /etc/apache2/.htpasswd Wayang (kemudian, masukkan password baratayudait03)`
3. `curl http://www.rjp.baratayuda.abimanyu.it03.com (tanpa auth)`
![image56](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/d150a27e-3e37-4c9c-ac4d-3449be4db139)
4. `curl http://www.rjp.baratayuda.abimanyu.it03.com:14000 -u Wayang:baratayudait03`
![image28](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/d3dd5dce-09ea-4f01-9d4d-f31cd0f5fb7c)

# Nomor 19
Setiap kali iases IP dari Abimanyu, akan secara otomatis dialihkan ke www.abimanyu.it03.com
## Abimanyu
### /etc/apache2/sites–available/abimanyu.it03.conf
Tambahkan konfigurasi:
`ServerAlias 10.65.4.3 #IP Abimanyu `

## Sadewa
Masukan command dibawah untuk periksa keberhasilan:
`lynx http://10.65.4.3`
![image44](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/affbff18-1aa1-46c2-a0e0-4ec76c3e054f)

# Nomor 20
Mengubah request gambar yang memiliki substring "abimanyu" akan diarahkan menuju abimanyu.png
## Abimanyu
### /etc/apache2/sites-available/parikesit.abimanyu.it03.conf
Tambahkan code sebagai berikut:
```
RewriteEngine On

    RewriteCond %{REQUEST_URI} abimanyu [NC]

    RewriteRule (.*) /public/images/abimanyu.png [L]
```

## Sadewa
Masukan command dibawah untuk periksa keberhasilan:
`lynx http://www.parikesit.abimanyu.it03.com/aksdjabimanyu`
![image37](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/6daa73a0-dde2-4a19-9094-dc3791e12921)
