#!/usr/bin/env bash

# Ensure git is setup correctly locally
./setup.sh -s

BRANCH=`git branch | grep \* | awk '{print $2}'`

git fetch source &> /dev/null
git cherry source/${BRANCH}