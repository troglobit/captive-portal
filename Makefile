# SPDX-License-Identifier: ISC
PREFIX ?= /usr/local
DISPATCHER = /etc/NetworkManager/dispatcher.d

all:
	@echo "Use 'sudo make install' to install to $(PREFIX) and set up a NetworkManager dispatcher."

# NM only scans dispatcher.d/; a symlink into no-wait.d/ makes it no-wait.
install:
	install -m 0755 captive-portal-login $(PREFIX)/bin/captive-portal-login
	install -m 0755 -o root -g root 90-captive-portal $(DISPATCHER)/no-wait.d/90-captive-portal
	ln -sf no-wait.d/90-captive-portal $(DISPATCHER)/90-captive-portal

uninstall:
	rm -f $(PREFIX)/bin/captive-portal-login $(DISPATCHER)/90-captive-portal \
		$(DISPATCHER)/no-wait.d/90-captive-portal

check:
	python3 test/fake-portal.py

.PHONY: install uninstall check
