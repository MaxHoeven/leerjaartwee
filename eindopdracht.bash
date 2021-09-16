#!/bin/bash

echo "Eerst installeren we webserver software"
echo "maak een keuze tussen apache en Nginx"
echo "Maak je keuze:"

read server
if ["$server"="apache"]
	then
		sudo apt update
		sudo apt install apache2 -y

		echo "apache2 is nu geïnstalleerd."

	fi 
if ["$server"="Nginx"]
    then
        echo "Nginx word nu geïnstalleerd"
        sudo apt update
        sudo apt install nginx php-fpm
		
		echo "Nginx is nu geïnstalleerd"
		
	fi
echo "We installeren nu de database software"

	sudo apt update
	sudo apt-get install mysql-server
    sudo mysql_secure_installation
    sudo mysql -u root -p
    show databases;
	
echo "MySQL is nu geïnstalleerd"

echo "We installeren nu NextCloud"

	sudo apt update
	sudo apt install php-fpm php-mbstring php-xmlrpc php-soap php-apcu php-smbclient php-ldap php-redis php-gd php-xml php-intl php-json php-imagick php-mysql php-cli php-mcrypt php-ldap php-zip php-curl
	sudo mysql -u root -ps

	sudo apt install php-fpm php-mbstring php-xmlrpc php-soap php-apcu php-smbclient php-ldap php-redis php-gd php-xml php-intl php-json php-imagick php-mysql php-cli php-mcrypt php-ldap php-zip php-curl
	sudo mysql -u root -p

echo "Nextcloud is nu geïnstalleerd"

echo "Nu installeren we fail2ban"

	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get install fail2ban
	
echo "fail2ban is nu geïnstalleerd"

echo "Vervolgens moeten we nog een Self Signed Certificate regelen"

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
sudo nano /etc/nginx/snippets/self-signed.conf
sudo nano /etc/nginx/snippets/ssl-params.conf
sudo nano /etc/nginx/sites-available/default

echo "We hebben nu een Self Signed Certificate geregelt"
echo "laten we ten slotte de firewall configureren"

apt-get iptables-persistent
ii iptables 1.4.12-1ubuntu4 administration tools for packet filtering and NAT
ip_tables 18106 1 iptable_filter
iptables -L

iptables -I INPUT -p tcp --dport 22 -s 192.168.1.1 -j ACCEPT
iptables -L
iptables -P INPUT DROP

iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -L -n

iptables -I INPUT -i lo -j ACCEPT
iptables -L -n

iptables -A INPUT -p tcp --dport 21 -j ACCEPT
iptables -A INPUT -p tcp --dport 20 -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -L -n

iptables -A INPUT -p tcp --dport 53 -j ACCEPT
iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -L -n

/etc/init.d/iptables-persistent save

runlevel
ls -la /etc/rc2.d/ | grep iptables

echo "de firewall is geconfigureert. 