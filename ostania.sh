echo nameserver 192.168.122.1 > /etc/resolv.conf

route add -net 0.0.0.0 netmask 0.0.0.0 gw 192.215.7.149

apt-get install nano -y
apt-get install isc-dhcp-relay -y
service isc-dhcp-relay restart

iptables -A PREROUTING -t nat -p tcp -d 192.217.7.139 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 192.217.7.131:80
iptables -A PREROUTING -t nat -p tcp -d 192.217.7.139 -j DNAT --to-destination 192.217.7.130:80


