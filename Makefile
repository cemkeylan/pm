PREFIX = /usr/local
BINDIR = ${PREFIX}/bin

install:
	install -Dm755 -t ${DESTDIR}${BINDIR} pm

uninstall:
	rm -f ${DESTDIR}${BINDIR}/pm

.PHONY: install uninstall
