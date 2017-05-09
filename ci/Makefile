PIPELINE=commit-queue
SSH_KEY=~/.ssh/personal_github_rsa

init: vagrant-up download-fly-osx login pipeline unpause-pipeline browse

vagrant-up:
	vagrant up

download-fly-osx:
	curl --user concourse:concourse -o fly 'http://192.168.100.4:8080/api/v1/cli?arch=amd64&platform=darwin'
	chmod +x fly

download-fly-linux:
	curl --user concourse:concourse -o fly 'http://192.168.100.4:8080/api/v1/cli?arch=amd64&platform=linux'
	chmod +x fly

login:
	./fly --target live login --concourse-url http://192.168.100.4:8080

pipeline:
	./fly --target live set-pipeline --pipeline ${PIPELINE} \
                                     --config pipelines/main.yml \
                                     --var "private-repo-key=`cat ${SSH_KEY}`" \
                                     --var "git-repo=`git remote -v | grep fetch | head -n 1 | awk '{print $$2}'`"

unpause-pipeline:
	./fly --target live unpause-pipeline --pipeline ${PIPELINE}

browse:
	open http://192.168.100.4:8080/teams/main/login
