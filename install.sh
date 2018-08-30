#!/usr/bin/env bash

setup() {
	export http_proxy https_proxy
	mkdir -p /var/cache/yum/{base,extras,updates}
	setup_cache
	sed -i '/^gpgkey=/a exclude=*.i386' /etc/yum.repos.d/CentOS-Base.repo
	# shellcheck disable=SC2016
  	sed -i 's/centos\/\$releasever/5.11/g' /etc/yum.repos.d/CentOS-Sources.repo
	rm -f /etc/yum.repos.d/libselinux.repo
}

setup_cache() {
	echo "http://vault.centos.org/5.11/os/x86_64/" > /var/cache/yum/base/mirrorlist.txt
	echo "http://vault.centos.org/5.11/extras/x86_64/" > /var/cache/yum/extras/mirrorlist.txt
	echo "http://vault.centos.org/5.11/updates/x86_64/" > /var/cache/yum/updates/mirrorlist.txt
}

install_deps() {
	yum install -y epel-release
	yum install -y --skip-broken make openssl tidy
	yum install -y libxslt php openssh openssh-clients git
}

clean() {
	yum clean all
	rm -rf /tmp/*
}

main() {
	cd /tmp/ &&
	setup &&
	install_deps &&
	clean
}

main "$@"