# Jarkom-Modul-2-IT03-2023-

## Kelompok: IT03
### Anggota: 
Nama | NRP
--- | ---
Adiba Zalfa Camilla | 5027211060
Wiridlangit Suluh Jiwangga | 5027211064

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
![image3](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/b574184c-8c30-4c50-b605-d19c67430a2f)

## Sadewa
Gunakan `nslookup parikesit.abimanyu.it03.com` untuk melihat output.
![image9](https://github.com/dibazalfa/Jarkom-Modul-2-IT03-2023/assets/113527799/afc40066-ac77-4147-a779-47916c121e39)

# Nomor 5
