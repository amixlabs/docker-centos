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

install_apache() {

	local names=(
		httpd
	)
	yum install -y "${names[@]}"
}

install_php() {

	local names=(
		php
		php-ldap
		php-soap
		php-cli
		php-pdo
		php-xml
		php-devel
		php-common
		php-mysql
		php-mcrypt
		php-mbstring
		php-xdebug
	)
	yum install -y "${names[@]}"
}

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

clean() {
	yum clean all
	rm -rf /tmp/*
}

main() {
	setup &&
	disable_selinux &&
	install_epel &&
	install_apache &&
	install_php &&
	install_composer &&
	install_nodejs &&
	clean
}

main "$@"