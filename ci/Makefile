# ------ Config ------
#
# By default lots of these are generated from
# details of the git repo but they can be replaced
# with specific values.
#

PIPELINE_NAME=`git remote -v | grep fetch | head -n 1 | sed 's/.*\/\(.*\)\..*/\1/'`
GIT_REPO=`git remote -v | grep fetch | head -n 1 | awk '{print $$2}'`
BRANCH=`git branch | grep \* | awk '{print $$2}'`
PROJECT_NAME=`git remote -v | grep fetch | head -n 1 | sed 's/.*:\(.*\)\..*/\1/'`
GIT_WEB_URL=`git remote -v | grep push | head -n 1 | sed 's/.*@\(.*\):\(.*\)\..*/https:\/\/\1\/\2/'`

SSH_KEY_PATH=~/.ssh/id_rsa
LIVE_URL=https://ci.concourse.ci
TEAM_NAME=main

# ------ Defaults ------
# You shouldn't need to change these

TARGET=			dev
URL=			http://192.168.100.4:8080
FLY-OS=				darwin

# --------------------

init: start-concourse pipeline-queue browse-dev

# Dev
login:
	./fly --target ${TARGET} login --concourse-url ${URL} --team-name ${TEAM_NAME} --insecure

pipeline: login
	./fly --target ${TARGET} set-pipeline --pipeline ${PIPELINE_NAME} \
									 --config pipeline.yml \
									 --load-vars-from config-${TARGET}.yml \
									 --var "private-repo-key=`cat ${SSH_KEY_PATH}`" \
									 --var "branch=${BRANCH}" \
									 --var "git-repo=${GIT_REPO}"
pipeline-queue: login
	./fly --target ${TARGET} set-pipeline --pipeline ${PIPELINE_NAME}_queue \
									 --config pipeline-queue.yml \
									 --load-vars-from config-${TARGET}.yml \
									 --var "private-repo-key=`cat ${SSH_KEY_PATH}`" \
									 --var "pending-branches=${BRANCH}-pending-\d*" \
									 --var "git-repo=${GIT_REPO}" \
									 --var "project-name=${PROJECT_NAME}" \
									 --var "git-web-url=${GIT_WEB_URL}" \
									 --var "concourse-url=${URL}"

# Live
live-login: TARGET=live
live-login: URL=${LIVE_URL}
live-login: login

live-pipeline: TARGET=live
live-pipeline: live-login pipeline

live-pipeline-queue: TARGET=live
live-login: URL=${LIVE_URL}
live-pipeline-queue: live-login pipeline-queue

# Setup
start-concourse:
	./util/setup-local-concourse

download-fly:
	./scripts/retry curl --user concourse:concourse -o fly '${URL}/api/v1/cli?arch=amd64&platform=${FLY-OS}' -m 30
	chmod +x fly

download-fly-linux: FLY-OS=linux download-fly
download-fly-win: FLY-OS=windows download-fly

config:
	cp -n ./config.yml.sample ./config-dev.yml || true
	cp -n ./config.yml.sample ./config-live.yml || true

browse-dev:
	open http://192.168.100.4:8080/teams/main/login