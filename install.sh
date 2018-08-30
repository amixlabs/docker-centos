#!/usr/bin/env bash

install_deps() {
	yum install -y make openssl tidy
}

clean() {
	yum clean all
	rm -rf /tmp/*
}

main() {
	cd /tmp/ &&
	install_deps &&
	clean
}

main "$@"