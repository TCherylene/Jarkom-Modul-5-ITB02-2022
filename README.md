# Jarkom-Modul-5-ITB02-2022

Anggota kelompok:

1. Asima Prima Y. Tampubolon 5027201009
2. Cherylene Trevina 5027201033
3. Fatih Rian Hibatul Hakim 5027201066

## Daftar Isi

* [Topologi](#topologi)
* [Subnetting](#subnetting)
    * [Pembagian Subnet](#pembagian-subnet)
    * [Pohon subnet](#pohon-subnet)
    * [Tabel subnet](#tabel-subnet)
* [Konfigurasi](#konfigurasi-gns3)
    * [Masing-masing node](#masing-masing-node)
    * [DNS, Web Server, DHCP Relay, DHCP Server](#dns-web-server-dhcp-relay-dhcp-server)
    * [DHCP Relay](#konfigurasi-ostania--westalis---dhcp-relay)
    * [DHCP Server](#konfigurasi-wise---dhcp-server)
    * [DNS Server](#konfigurasi-eden---dns-server)
* [Routing](#routing)

Pengerjaan soal:

* [Soal 1](#soal-1) & [Jawaban](#jawaban-soal-1)
* [Soal 2](#soal-2) & [Jawaban](#jawaban-soal-2)
* [Soal 3](#soal-3) & [Jawaban](#jawaban-soal-3)
* [Soal 1](#soal-4) & [Jawaban](#jawaban-soal-4)

## Topologi

Pembuatan topologi dengan keterangan:

* Eden adalah DNS Server
* WISE adalah DHCP Server
* Garden dan SSS adalah Web Server
* Jumlah Host pada Forger adalah 62 host
* Jumlah Host pada Desmond adalah 700 host
* Jumlah Host pada Blackbell adalah 255 host
* Jumlah Host pada Briar adalah 200 host

Topologi yang telah dibuat:
<!-- Monggo kim -->

## Subnetting

### Pembagian Subnet

### Pohon Subnet

### Tabel Subnet

## Konfigurasi GNS3

### Masing-masing Node

### DNS, Web Server, DHCP Relay, DHCP Server

### Konfigurasi Ostania & Westalis - DHCP Relay

### Konfigurasi WISE - DHCP Server

### Konfigurasi Eden - DNS SERVER

## Routing

## Soal 1

Agar topologi yang kalian buat dapat mengakses keluar, kalian diminta untuk mengkonfigurasi Strix menggunakan iptables, tetapi Loid tidak ingin menggunakan MASQUERADE.

## Jawaban Soal 1

Pada node Strix, masukkan command berikut:

```sh
IPETH0="$(ip -br a | grep eth0 | awk '{print $NF}' | cut -d'/' -f1)"

iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source "$IPETH0" -s 192.215.0.0/21
```

Selanjutnya, dilakukan tes ping ke google dengan hasil sebagai berikut:

![Tes Ping](images/1-testPing.png)

## Soal 2

Kalian diminta untuk melakukan drop semua TCP dan UDP dari luar Topologi kalian pada server yang merupakan DHCP Server demi menjaga keamanan.

## Jawaban Soal 2

Untuk menyelesaikan soal ini, pada node **Strix**, masukkan command:

```sh
iptables -A FORWARD -d 192.215.7.131 -i eth0 -p tcp --dport 80 -j DROP
```

## Soal 3

Loid meminta kalian untuk membatasi DHCP dan DNS Server hanya boleh menerima maksimal 2 koneksi ICMP secara bersamaan menggunakan iptables, selebihnya didrop.

## Jawaban Soal 3

Pada soal ini, masukkan command berikut pada **DHCP Server (WISE)** & **DNS Server (Eden)**

```sh
iptables -A INPUT -p icmp -m connlimit --connlimit-above 2 --connlimit-mask 0 -j DROP
```

Tes ping dari keempat node:

![tes ping 1](images/3-tes%20ping%201.png)

![tes ping 2](images/3-tes%20ping%202.png)

![tes ping 3](images/3-tes%20ping%203.png)

## Soal 4

Akses menuju Web Server hanya diperbolehkan disaat jam kerja yaitu Senin sampai Jumat pada pukul 07.00 - 16.00.

## Jawaban Soal 4

Untuk pembatasan akses pada jam tersebut, kami menggunakan command berikut untuk Web Server (Forger & Desmond):

Forger

```sh
iptables -A INPUT -s 192.215.7.0/25 -m time --timestart 07:00 --timestop 16:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT
iptables -A INPUT -s 192.215.7.0/25 -j REJECT
```

Desmond

```sh
iptables -A INPUT -s 192.215.0.0/22 -m time --timestart 07:00 --timestop 16:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT
iptables -A INPUT -s 192.215.0.0/22 -j REJECT

```

Selanjutnya, testingnya seperti berikut:

Cek tanggal dan jam sekarang

![cek tanggal](images/4-cek%20tanggal.png)

Tes ping

![tes ping 1](images/4-tes%20ping%201.png)

![tes ping 2](images/4-tes%20ping%202.png)
