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
- [Nomor 4](#nomor-4)
- [Nomor 5](#nomor-5)
- [Nomor 6](#nomor-6)
- [Nomor 7](#nomor-7)
- [Nomor 8](#nomor-8)
- [Nomor 9](#nomor-9)
- [Nomor 10](#nomor-10)
- [Nomor 11](#nomor-11)
- [Nomor 12](#nomor-12)
- [Nomor 13](#nomor-13)
- [Nomor 14](#nomor-14)

# Konfigurasi
Install bind9 pada node **Yudhistira** dan **Werkudara**.
Berikut langkah Instalasi bind9:
1. `apt-get update`
2. `apt-get install bind9`

# Nomor 1
Menggunakan Topologi ke-3 pada drive yang telah disediakan. Lalu masukan konfigruasi network pada seetiap node.

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
Sama seperti nomor 2 hanya saja mengganti `arjuna` menjadi `abimanyu`.
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

# Nomor 4 (subdomain)
Membuat subdomain pada `abimanyu`
## Yudhistira
### /etc/bind/jarkom/abimanyu.it03.com
Tambah konfigruasi `parikesit	IN	A		10.65.4.3 #IP Abimanyu`
![image3](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/7b9c9801-9862-47ad-9a94-0b6f5888aa60)


## Sadewa
Gunakan `nslookup parikesit.abimanyu.it03.com` untuk melihat output.
![image9](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/b5e7dc86-3d8e-43ce-993e-127485378e5c)


# Nomor 5 (reverse dns)
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

