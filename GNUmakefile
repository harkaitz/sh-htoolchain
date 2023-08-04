PROJECT=sh-htoolchain
VERSION=1.0.0
PREFIX=/usr/local
all:
clean:
install:

## -- BLOCK:sh --
install: install-sh
install-sh:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp bin/img2tar          $(DESTDIR)$(PREFIX)/bin
	cp bin/hautotools       $(DESTDIR)$(PREFIX)/bin
	cp bin/sysroot-fix      $(DESTDIR)$(PREFIX)/bin
	cp bin/hgmake           $(DESTDIR)$(PREFIX)/bin
	cp bin/hmeson           $(DESTDIR)$(PREFIX)/bin
	cp bin/cc-vers          $(DESTDIR)$(PREFIX)/bin
	cp bin/hcross-env-c     $(DESTDIR)$(PREFIX)/bin
	cp bin/hcross           $(DESTDIR)$(PREFIX)/bin
	cp bin/hcmake           $(DESTDIR)$(PREFIX)/bin
	cp bin/cc-info          $(DESTDIR)$(PREFIX)/bin
## -- BLOCK:sh --
## -- BLOCK:license --
install: install-license
install-license: 
	mkdir -p $(DESTDIR)$(PREFIX)/share/doc/$(PROJECT)
	cp LICENSE README.md $(DESTDIR)$(PREFIX)/share/doc/$(PROJECT)
update: update-license
update-license:
	ssnip README.md
## -- BLOCK:license --
