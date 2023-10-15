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

