#!/bin/bash
################################################################################
#
#	Xavatar / Tatar
#
################################################################################
green=`tput setaf 2`


	# Mise à jour du system

    echo ""
    echo "${green}Updating system and installing required packages."
    echo ""
	
	yum -y update
	yum -y upgrade
	yum -y groupinstall "Development Tools" 
	yum -y install gmp-devel mysql-devel curl-devel libidn-devel libssh2-devel python-devel openldap-devel vim memcached wget git
	echo ""
    echo "${green}Arret du Firewall :"
	echo ""
	systemctl stop firewalld
	echo ""
	systemctl status firewalld
	echo ""
	echo "${green}Vérifixation de SeLinux :"
	echo ""
	sestatus
	echo ""
	sleep 3
	clear
	
	
	# Installation NGINX
	clear
	sleep 1
	echo ""
    echo "${green}Installation NGINX :"
    echo ""
	yum -y install nginx
	echo ""
	systemctl start nginx.service
	systemctl enable nginx.service
	echo ""
    echo "${green}Vérification de NGINX :"
	echo ""
	systemctl status nginx.service
	echo ""
	sleep 3
	clear
	
		
	# Installation DB (MariaDB)
	clear
	echo ""
    echo "${green}Installation MariaDB :"
    echo ""
	yum -y install mariadb-server mariadb
	systemctl start mariadb 
	systemctl enable mariadb
	echo ""
    echo "${green}Vérification de DB :"
	echo ""
	systemctl status mariadb.service
	echo "${green}Mise en route DB :"
	mysql_secure_installation
	echo ""
	sleep 3
	clear
	
	# Installation PHP
	clear
	echo ""
    echo "${green}Installation PHP :"
    echo ""
	yum -y install php php-mysql php-common php-fpm php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap php-mcrypt curl curl-devel php-memcache
	systemctl start memcached
	systemctl enable memcached
	echo ""
    echo "${green}Vérification de Memcache :"
	echo ""
	systemctl status memcached
	echo ""
	sleep 3
	clear
	
	
	# Installation APC
	clear
	echo ""
    echo "${green}Installation APC :"
    echo ""
	yum -y install php-pear php-devel httpd-devel pcre-devel gcc make
	cd
	pecl install apc
	echo "extension=apc.so" > /etc/php.d/apc.ini
	echo ""
	sleep 3
	clear
	
	
	# Installation phpMyAdmin
	clear
	echo ""
    echo "${green}Installation phpMyAdmin :"
    echo ""
	yum -y install phpMyAdmin
	echo ""
    echo "${green}Relance Apache :"
	echo ""
	systemctl restart nginx.service
	echo ""
	echo ""
	systemctl status nginx.service
	echo ""
	echo ""
	echo "${green}Installation Finish. Voir le readme pour la conf."