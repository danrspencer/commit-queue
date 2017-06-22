setup: setup-pre-push setup-push-script

setup-pre-push:
	cp ./ci/utils/pre-push ./.git/hooks/

setup-push-script:
	cp ./ci/utils/p2q /usr/local/bin/

disable-pre-push:
	@echo
	@echo "\033[1;31mYou'd better be doing this for a good reason or I will strike \033[0m"
	@echo "\033[1;31mdown upon thee with great vengeance and furious anger!  \033[0m"
	@echo
	rm ./.git/hooks/pre-push