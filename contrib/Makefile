PREFIX = /usr/local
BINDIR = ${PREFIX}/bin
contrib = pm-add-dmenu pm-ask pm-copy pm-copy-dmenu pm-git pm-tree

install:
	install -Dm755 -t ${DESTDIR}${BINDIR} ${contrib}

uninstall:
	for bin in ${contrib} ; do \
		rm -f ${DESTDIR}${BINDIR}/$$bin ; done
