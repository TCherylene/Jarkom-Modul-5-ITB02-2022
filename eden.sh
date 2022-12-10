echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get install nano -y
apt-get install bind9 -y

echo "
options {
        directory \"/var/cache/bind\";
        forwarders {
                192.168.122.1;
        };
        allow-query{any;};
        auth-nxdomain no;
        listen-on-v6 { any; };
};

" > /etc/bind/named.conf.options

#nomor 3
iptables -A INPUT -p icmp -m connlimit --connlimit-above 2 --connlimit-mask 0 -j DROP

#nomor4 forger
iptables -A INPUT -s 192.215.7.0/25 -m time --timestart 07:00 --timestop 16:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT
iptables -A INPUT -s 192.215.7.0/25 -j REJECT


#nomor4 desmond
iptables -A INPUT -s 192.215.0.0/22 -m time --timestart 07:00 --timestop 16:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT
iptables -A INPUT -s 192.215.0.0/22 -j REJECT


service bind9 restart