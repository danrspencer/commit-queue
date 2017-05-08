REMOTE=git@github.com:danrspencer/commit-queue-pending.git

setup: setup-push-remote

setup-push-remote:
	@git config remote.origin.pushurl ${REMOTE}
	@git remote -v