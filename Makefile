PREFIX ?= /usr/local
TASK_DONE = echo -e "\n✓ $@ done\n"

.PHONY: test

all:
	@echo "Usage:"
	@echo "  make install"
	@echo "  make reinstall"
	@echo "  make uninstall"
	@echo "  make test"

help:
	$(MAKE) all
	@$(TASK_DONE)

install:
	mkdir -p $(PREFIX)/bin
	install -m 0755 git-quick-stats $(PREFIX)/bin/git-quick-stats
	git config --global alias.quick-stats '! $(PREFIX)/bin/git-quick-stats'
	$(MAKE) man
	@$(TASK_DONE)

uninstall:
	test -d $(PREFIX)/bin && \
	cd $(PREFIX)/bin && \
	rm -f git-quick-stats && \
	git config --global --unset alias.quick-stats
	@$(TASK_DONE)

reinstall:
	@curl -s https://raw.githubusercontent.com/arzzen/git-quick-stats/master/git-quick-stats > git-quick-stats
	$(MAKE) uninstall && \
	$(MAKE) install
	@$(TASK_DONE)

man:
	install -g 0 -o 0 -m 0644 git-quick-stats.1 /usr/share/man/man1/

test:
	tests/commands_test.sh
	@$(TASK_DONE)
