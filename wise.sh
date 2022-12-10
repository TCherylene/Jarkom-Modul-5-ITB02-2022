echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get install nano -y

apt-get install isc-dhcp-server -y

echo "
INTERFACES=\"eth0\"
" > /etc/default/isc-dhcp-server

echo "
ddns-update-style none;
option domain-name "example.org";
option domain-name-servers ns1.example.org, ns2.example.org;
default-lease-time 600;
max-lease-time 7200;
log-facility local7;
subnet 192.215.0.0 netmask 255.255.252.0 {
    range 192.215.0.2 192.215.3.254;
    option routers 192.215.0.1;
    option broadcast-address 192.215.3.255;
    option domain-name-servers 192.215.7.130;
    default-lease-time 360;
    max-lease-time 7200;
}
subnet 192.215.7.0 netmask 255.255.255.128 {
    range 192.215.7.2 192.215.7.126;
    option routers 192.215.7.1;
    option broadcast-address 192.215.7.127;
    option domain-name-servers 192.215.7.130;
    default-lease-time 720;
    max-lease-time 7200;
}
subnet 192.215.4.0 netmask 255.255.254.0 {
    range 192.215.4.2 192.215.5.254;
    option routers 192.215.4.1;
    option broadcast-address 192.215.5.255;
    option domain-name-servers 192.215.7.130;
    default-lease-time 720;
    max-lease-time 7200;
}
subnet 192.215.6.0 netmask 255.255.255.0 {
    range 192.215.6.2 192.215.6.254;
    option routers 192.215.6.1;
    option broadcast-address 192.215.6.255;
    option domain-name-servers 192.215.7.130;
    default-lease-time 720;
    max-lease-time 7200;
}
subnet 192.215.7.128 netmask 255.255.255.248 {}
subnet 192.215.7.144 netmask 255.255.255.252 {}
subnet 192.215.7.148 netmask 255.255.255.252 {}
subnet 192.215.7.136 netmask 255.255.255.248 {}
" > /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart

#nomor 3
iptables -A INPUT -p icmp -m connlimit --connlimit-above 2 --connlimit-mask 0 -j DROP