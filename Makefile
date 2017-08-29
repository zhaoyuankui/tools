.PHONY: all install clean uninstall
all:
	@for tool in `ls .`; do \
	    if [ -f "$${tool}/Makefile" ]; then \
		    echo "============ Make tool '$${tool}' ============"; \
		    make -C $${tool}; \
		fi \
	done
install:
	@for tool in `ls .`; do \
	    if [ -f "$${tool}/Makefile" ]; then \
		    echo "============ Install tool '$${tool}' ============"; \
		    make -C $${tool} install; \
		fi \
	done
clean:
	@for tool in `ls .`; do \
	    if [ -f "$${tool}/Makefile" ]; then \
		    echo "============ Clean tool '$${tool}' ============"; \
		    make -C $${tool} clean; \
		fi \
	done
uninstall:
	echo "Do nothing."
