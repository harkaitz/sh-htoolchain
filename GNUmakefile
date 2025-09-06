PROJECT=sh-htoolchain
VERSION=1.0.0
PREFIX=/usr/local
all:
clean:
install:

## -- BLOCK:license --
install: install-license
install-license: README.md LICENSE
	install -d $(DESTDIR)$(PREFIX)/share/doc/$(PROJECT)
	install -c -m 644 README.md LICENSE $(DESTDIR)$(PREFIX)/share/doc/$(PROJECT)
## -- BLOCK:license --
## -- BLOCK:sh --
install: install-sh
install-sh:
	install -d $(DESTDIR)$(PREFIX)/bin
	install -c -m 755 bin/img2tar $(DESTDIR)$(PREFIX)/bin
	install -c -m 755 bin/x86_64-w64-mingw32-env $(DESTDIR)$(PREFIX)/bin
	install -c -m 755 bin/hautotools $(DESTDIR)$(PREFIX)/bin
	install -c -m 755 bin/sysroot-fix $(DESTDIR)$(PREFIX)/bin
	install -c -m 755 bin/hgmake $(DESTDIR)$(PREFIX)/bin
	install -c -m 755 bin/hmeson $(DESTDIR)$(PREFIX)/bin
	install -c -m 755 bin/cc-vers $(DESTDIR)$(PREFIX)/bin
	install -c -m 755 bin/gcc-env $(DESTDIR)$(PREFIX)/bin
	install -c -m 755 bin/x86_64-linux-gnu-env $(DESTDIR)$(PREFIX)/bin
	install -c -m 755 bin/hcross-env-c $(DESTDIR)$(PREFIX)/bin
	install -c -m 755 bin/aarch64-linux-gnu-env $(DESTDIR)$(PREFIX)/bin
	install -c -m 755 bin/hcross $(DESTDIR)$(PREFIX)/bin
	install -c -m 755 bin/hcmake $(DESTDIR)$(PREFIX)/bin
	install -c -m 755 bin/tar-install $(DESTDIR)$(PREFIX)/bin
	install -c -m 755 bin/hdeploy $(DESTDIR)$(PREFIX)/bin
	install -c -m 755 bin/i686-w64-mingw32-env $(DESTDIR)$(PREFIX)/bin
	install -c -m 755 bin/hrelease $(DESTDIR)$(PREFIX)/bin
	install -c -m 755 bin/htriplet $(DESTDIR)$(PREFIX)/bin
	install -c -m 755 bin/make-h-release $(DESTDIR)$(PREFIX)/bin
        ifeq($(UNAME_S),Linux)
	  install -c -m 755 bin/lsetup-gcc-glibc $(DESTDIR)$(PREFIX)/bin
	  install -c -m 755 bin/lsetup-gcc-musl $(DESTDIR)$(PREFIX)/bin
        endif
## -- BLOCK:sh --
