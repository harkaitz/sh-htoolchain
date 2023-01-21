DESTDIR     =
PREFIX      =/usr/local
all:
clean:
install:
## -- install-sh --
install: install-sh
install-sh:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp bin/img2tar          $(DESTDIR)$(PREFIX)/bin
	cp bin/hautotools       $(DESTDIR)$(PREFIX)/bin
	cp bin/sysroot-fix      $(DESTDIR)$(PREFIX)/bin
	cp bin/hgmake           $(DESTDIR)$(PREFIX)/bin
	cp bin/hmeson           $(DESTDIR)$(PREFIX)/bin
	cp bin/hcross-env-c     $(DESTDIR)$(PREFIX)/bin
	cp bin/hcross           $(DESTDIR)$(PREFIX)/bin
	cp bin/hcmake           $(DESTDIR)$(PREFIX)/bin
	cp bin/cc-info          $(DESTDIR)$(PREFIX)/bin
## -- install-sh --
## -- license --
install: install-license
install-license: LICENSE
	mkdir -p $(DESTDIR)$(PREFIX)/share/doc/sh-htoolchain
	cp LICENSE $(DESTDIR)$(PREFIX)/share/doc/sh-htoolchain
## -- license --
