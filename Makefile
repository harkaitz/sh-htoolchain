DESTDIR     =
PREFIX      =/usr/local
SCRIPTS_BIN=$(shell find bin -executable -type f)
all:
clean:
install:
    ifneq ($(SCRIPTS_BIN),)
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp $(SCRIPTS_BIN) $(DESTDIR)$(PREFIX)/bin
    endif
