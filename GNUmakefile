PROJECT=sh-htoolchain
VERSION=1.0.0
PREFIX=/usr/local
all:
clean:
install:

## -- BLOCK:license --
install: install-license
install-license: README.md LICENSE
	mkdir -p $(DESTDIR)$(PREFIX)/share/doc/$(PROJECT)
	cp README.md LICENSE $(DESTDIR)$(PREFIX)/share/doc/$(PROJECT)
## -- BLOCK:license --
## -- BLOCK:sh --
install: install-sh
install-sh:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp bin/img2tar $(DESTDIR)$(PREFIX)/bin
	cp bin/x86_64-w64-mingw32-env $(DESTDIR)$(PREFIX)/bin
	cp bin/hautotools $(DESTDIR)$(PREFIX)/bin
	cp bin/sysroot-fix $(DESTDIR)$(PREFIX)/bin
	cp bin/hgmake $(DESTDIR)$(PREFIX)/bin
	cp bin/hmeson $(DESTDIR)$(PREFIX)/bin
	cp bin/cc-vers $(DESTDIR)$(PREFIX)/bin
	cp bin/gcc-env $(DESTDIR)$(PREFIX)/bin
	cp bin/x86_64-linux-gnu-env $(DESTDIR)$(PREFIX)/bin
	cp bin/hcross-env-c $(DESTDIR)$(PREFIX)/bin
	cp bin/aarch64-linux-gnu-env $(DESTDIR)$(PREFIX)/bin
	cp bin/hcross $(DESTDIR)$(PREFIX)/bin
	cp bin/hcmake $(DESTDIR)$(PREFIX)/bin
	cp bin/tar-install $(DESTDIR)$(PREFIX)/bin
	cp bin/hdeploy $(DESTDIR)$(PREFIX)/bin
	cp bin/hrelease $(DESTDIR)$(PREFIX)/bin
	cp bin/htriplet $(DESTDIR)$(PREFIX)/bin
## -- BLOCK:sh --
