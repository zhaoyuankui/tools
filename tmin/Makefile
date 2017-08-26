.PHONY: all install clean uninstall
all:
	mkdir -p output/bin output/conf
	cp -f src/tmin output/bin/tmin
install:
	if [ "`ls output/bin`" ]; then chmod +x output/bin/*;cp -pf output/bin/* ~/bin;fi
	if [ "`ls output/conf`" ]; then cp -f output/conf/* ~/bin/conf; fi
clean:
uninstall:
