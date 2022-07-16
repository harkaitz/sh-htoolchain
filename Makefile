DESTDIR     =
PREFIX      =/usr/local
all:
clean:
install:
## -- license --
ifneq ($(PREFIX),)
install: install-license
install-license: LICENSE
	mkdir -p $(DESTDIR)$(PREFIX)/share/doc/sh-htoolchain
	cp LICENSE $(DESTDIR)$(PREFIX)/share/doc/sh-htoolchain
endif
## -- license --
## -- install-sh --
install: install-sh
install-sh:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp bin/hautotools bin/hcmake bin/setup-devel-c-native bin/hgmake bin/hmeson bin/hcross bin/sysroot-fix bin/hcross-env-c  $(DESTDIR)$(PREFIX)/bin
## -- install-sh --
