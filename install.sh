#!/usr/bin/env bash

setup() {
	export http_proxy https_proxy no_proxy
}

disable_selinux() {
	if [[ -f /etc/sysconfig/selinux ]]; then
		sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/sysconfig/selinux
		setenforce 0
	fi
}

install_epel() {
	yum install -y epel-release
}

install_tools() {
	yum install -y openssh-clients rsync
}

install_mariadb() {
	yum install -y mariadb
}

install_apache() {

	local names=(
		httpd
	)
	yum install -y "${names[@]}"
}

install_php() {

	local names=(
		php
		php-gd
		php-ldap
		php-soap
		php-bcmath
		php-cli
		php-pdo
		php-xml
		php-devel
		php-common
		php-mysql
		php-pgsql
		php-mcrypt
		php-mbstring
		php-pecl-redis
		php-pecl-apcu
		php-xdebug
	)
	yum install -y "${names[@]}"
    sed -i '/^;date.timezone/adate.timezone = America/Sao_Paulo' /etc/php.ini
}

install_php_pdo_oci() (
	set -e
	yum install -y yum-utils bzip2 libaio gcc make
	yumdownloader --source php
	mkdir php
	cd php
	rpm2cpio ../php-*.src.rpm | cpio -idmv --no-absolute-filenames
	tar xjvf php-*.tar.bz2
	cd php-*/ext/pdo_oci/
	phpize
	curl -LO 'https://www.dropbox.com/s/opng2o5jrv9q1fs/oracle-instantclient11.2-devel-11.2.0.4.0-1.x86_64.rpm'
	curl -LO 'https://www.dropbox.com/s/xypfq6nvgf8gwgt/oracle-instantclient11.2-basic-11.2.0.4.0-1.x86_64.rpm'
	rpm -i oracle-*.rpm
	./configure --with-pdo-oci=instantclient,/usr,11.2
	make
	make install
	cat <<-EOT >/etc/php.d/pdo_oci.ini
	; Enable pdo_oci extension module
	extension=pdo_oci.so
	EOT
)

install_composer() {
	if [[ -x /usr/local/bin/composer ]]; then
		return 0
	fi
	curl -sS https://getcomposer.org/installer | php
	mv composer.phar /usr/local/bin/composer
}

install_nodejs() {
    # Repositório Oficial NodeJS
    curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -
    yum install -y nodejs
    npm upgrade -g npm
    # check version npm and node
    # npm version
}

install_git() {
	yum install -y git
}

clean() {
	yum remove -y yum-utils gcc make
	yum clean all
	rm -rf /tmp/*
}

main() {
	cd /tmp/ &&
	setup &&
	disable_selinux &&
	install_tools &&
	install_mariadb &&
	install_epel &&
	install_apache &&
	install_php &&
	install_php_pdo_oci &&
	install_composer &&
	install_nodejs &&
	install_git &&
	clean
}

main "$@"