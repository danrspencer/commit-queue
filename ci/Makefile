PIPELINE=commit-queue
SSH_KEY=~/.ssh/personal_github_rsa

init: download-fly-osx login pipeline unpause-pipeline browse

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
                                     --var "fetch-repo=`git remote -v | grep fetch | awk '{print $$2}'`" \
                                     --var "push-repo=`git remote -v | grep push | awk '{print $$2}'`"

unpause-pipeline:
	./fly --target live unpause-pipeline --pipeline ${PIPELINE}

browse:
	open http://192.168.100.4:8080/teams/main/login
