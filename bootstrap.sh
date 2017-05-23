#!/usr/bin/env bash

REPO=commit-queue
BRANCH=master
URL=https://github.com/danrspencer/${REPO}/archive/${BRANCH}.zip

curl -L -O ${URL}
unzip ./master.zip
rm ./master.zip

mv ./${REPO}-${BRANCH}/ci ./ci
mv ./${REPO}-${BRANCH}/scripts ./scripts
mv ./${REPO}-${BRANCH}/Makefile ./Makefile
rm -rf ${REPO}-${BRANCH}

make

cd ./ci

vagrant init concourse/lite
make