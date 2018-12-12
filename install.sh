#!/usr/bin/env bash

install_tools() {
	yum install -y openssh-clients rsync libaio zip unzip
}

install_epel() {
	yum install -y epel-release
}

install_remi() {
	yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
    yum install -y yum-utils
    yum-config-manager --enable remi-php71
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
		php-oci8
		php-xml
		php-devel
		php-common
		php-mysql
		php-pgsql
		php-mcrypt
		php-mbstring
		php-pecl-redis
		php-pecl-apcu
		php-pecl-zendopcache
		php-pecl-mongodb
		php-pecl-zip
		php-xdebug
		php-zip
		php-intl
	)
	yum install -y "${names[@]}"
}

install_instantclient() {
	curl -LO 'https://www.dropbox.com/s/2n09xqw966a7a34/oracle-instantclient18.3-basic-18.3.0.0.0-1.x86_64.rpm'
	rpm -i oracle-*.rpm
}

install_composer() {
	if [[ -x /usr/local/bin/composer ]]; then
		return 0
	fi
	curl -sS https://getcomposer.org/installer | php
	mv composer.phar /usr/local/bin/composer
}

install_git() {
	yum install -y git
}

install_node() {
	curl -sL https://rpm.nodesource.com/setup_10.x | bash -
	yum install -y nodejs
}

upgrade_npm() {
	npm install -g npm
}

clean() {
	yum clean all
	rm -rf /tmp/*
}

main() {
	cd /tmp/ &&
	install_tools &&
	install_epel &&
	install_remi &&
	install_instantclient &&
	install_php &&
	install_apache &&
	install_composer &&
	install_git &&
	install_node &&
	upgrade_npm &&
	clean
}

main "$@"