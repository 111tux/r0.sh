#!/bin/sh

#| name		r0.sh
#| version      0.1 alpha
#| author	111tux
#| what		sh script for building own linux router with a high requirement on network security on all ISO-OSI network layers
#| howto run	chmod +x ./r0.sh;./r0.sh
#| tested on	
#|  hardware	pi4
#|  os		debian

#> why
#| no ads on all network devices (:
#| full control of my home network
#| secure my home network
#| setup network from scratch
#| security_research > understanding of how things (work | are implemented)
#| good project for starting with a more complex home network
#| cheaper than commercial routers

#> why debian
#| debian is (free & opensource) software and will always be 100% free
#| debian is the largest community-run linux distribution
#| a lot of linux distributions are debian-based, eg ubuntu,kali,mint
#| debian runs on nearly every processor architecture, thus r0.sh runs also on nearly every cpu architecture (if this is wrong, pls correct me)
#| ideal for servers, because it's extreme stable
#| debian names their versions after toy story names

#> research
#| !!! why static route to next hop is better, as static route to (broadcast | local) interface:
#| https://networkengineering.stackexchange.com/questions/7220/static-routes-numerical-next-hop-vs-interface
#| 
#| interesting article about ipv6
#| https://arstechnica.com/information-technology/2016/01/ipv6-celebrates-its-20th-birthday-by-reaching-10-percent-deployment/


#> FUTURE WORK
#|  implement ipv6
#|  BIND9 as main DNS server
#|  write (complete & secure) ssh cfg
#|  performance benchmark; network speed optimization
#|  display network information via 4-inch miuzei display
#|  arp spoof detection

#> THX
#| 
#| 

#> INSTALATION & RUN
#| type into linux terminal (but of course without #|):
#| cd /opt;git clone https://github.com/111tux/r0.sh;cd ./r0.sh;chmod +x ./r0.sh;./r0.sh

#> GO GO GO!
#| update,upgrade&install
apt update && apt -y dist-upgrade
#| install needed packages
apt -y install net-tools
#| OPTIONAL
apt -y install keyboard-configuration console-setup

#> setting up network_interfaces
#| eth0
echo -e "auto eth0\niface eth0 inet static\n\taddress 192.168.0.254\n\tnetmask 255.255.255.0\n\tgateway 192.168.0.1" > /etc/network/interfaces.d/eth0
#| wifi0
echo -e "auto eth0\niface wifi0 inet static\n\taddress 192.168.2.254\n\tnetmask 255.255.255.0\n\tgateway 192.168.0.254" > /etc/network/interfaces.d/wifi0

#| disable ipv6

#> ssh
#| only (alpha | beta) 'hack'
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
#| write own ssh cfg
#| FUTURE WORK

#> dns
#| OPTION_0: PYHOLE
#|           Network-wide ad blocking via your own Linux hardware
#|           The Pi-hole® is a DNS sinkhole that protects your devices from unwanted content, without installing any client-side software.
#|           https://github.com/pi-hole/pi-hole

#| OPTION_1: BIND9 (Berkeley Internet Name Daemon)
#|           BIND, or named, is an implementation of the Domain Name System (DNS) of the Internet.
#|           It performs both of the main DNS server roles, acting as an authoritative name server for domains,
#|           and acting as a recursive resolver in the network. As of 2015, it is the most widely used domain name server software
#|           and is the de facto standard on Unix-like operating systems
#|           https://en.wikipedia.org/wiki/BIND
#|           https://www.linuxtechi.com/install-configure-bind-9-dns-server-ubuntu-debian/
#|           FUTURE WORK - L0L

#| OPTION_2: PYHOLE uses local BIND instance as main DNS server
#|           OBVIOUSLY ALSO FUTURE WORK

#| EXTRA:    running BIND9 as (internal & external) DNS server
#|           https://www.howtoforge.com/two_in_one_dns_bind9_views
#|           [i will create a dedicated external BIND9 instance, but r0.sh will handle the port forwarding for this]

#> dhcp [wifi0]
#| The udhcp server is targeted deliberately at embedded environments
#| https://udhcp.busybox.net/
#|
#| 604800s=1week
apt -y install udhcpc
echo -e "start 192.168.2.50\nend 192.168.2.250\ninterface wifi0\noption subnet 255.255.255.0\noption router 192.168.0.1\noption lease 604800\noption\ndns 192.168.2.254\noption domain local" > /etc/udhcpc.conf

#> iptables

#> routing

#> vpn

