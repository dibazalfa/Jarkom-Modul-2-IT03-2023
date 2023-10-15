echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install dnsutils

echo nameserver 10.65.1.2 > /etc/resolv.conf
echo nameserver 10.65.2.2 > /etc/resolv.conf
