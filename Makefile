DESTDIR     =
PREFIX      =/usr/local
all:
clean:
install:
## -- license --
ifneq ($(PREFIX),)
install: install-license
install-license: LICENSE
	@echo 'I share/doc/sh-htoolchain/LICENSE'
	@mkdir -p $(DESTDIR)$(PREFIX)/share/doc/sh-htoolchain
	@cp LICENSE $(DESTDIR)$(PREFIX)/share/doc/sh-htoolchain
endif
## -- license --
## -- install-sh --
install: install-sh
install-sh:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@echo 'I bin/hautotools'; cp bin/hautotools  $(DESTDIR)$(PREFIX)/bin
	@echo 'I bin/hcmake'    ; cp bin/hcmake      $(DESTDIR)$(PREFIX)/bin
	@echo 'I bin/gcc-info'  ; cp bin/gcc-info    $(DESTDIR)$(PREFIX)/bin
	@echo 'I bin/hgmake'    ; cp bin/hgmake      $(DESTDIR)$(PREFIX)/bin
	@echo 'I bin/htest'     ; cp bin/htest       $(DESTDIR)$(PREFIX)/bin
	@echo 'I bin/hmeson'    ; cp bin/hmeson      $(DESTDIR)$(PREFIX)/bin
	@echo 'I bin/hcross'    ; cp bin/hcross      $(DESTDIR)$(PREFIX)/bin
	@echo 'I bin/sysroot-fix'; cp bin/sysroot-fix $(DESTDIR)$(PREFIX)/bin
	@echo 'I bin/hcross-env-c'; cp bin/hcross-env-c $(DESTDIR)$(PREFIX)/bin
## -- install-sh --
