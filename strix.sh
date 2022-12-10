apt-get update -y
apt-get install nano -y
apt-get install isc-dhcp-relay -y

route add -net 192.215.7.128 netmask 255.255.255.248 gw 192.215.7.146 #Eden & Wise
route add -net 192.215.7.0 netmask 255.255.255.128 gw 192.215.7.146 #Forger
route add -net 192.215.0.0 netmask 255.255.252.0 gw 192.215.7.146 #Desmond

route add -net 192.215.7.136 netmask 255.255.255.248 gw 192.215.7.150 #Garden & SSS
route add -net 192.215.6.0 netmask 255.255.255.0 gw 192.215.7.150 #Briar
route add -net 192.215.4.0 netmask 255.255.254.0 gw 192.215.7.150 #Blackbell

#nomor 1
IPETH0="$(ip -br a | grep eth0 | awk '{print $NF}' | cut -d'/' -f1)"
iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source "$IPETH0" -s 192.215.0.0/21

#nomor 2
iptables -A FORWARD -d 192.215.7.131 -i eth0 -p tcp --dport 80 -j DROP
iptables -A FORWARD -d 192.215.7.130 -i eth0 -p tcp --dport 80 -j DROP


service isc-dhcp-relay restart