#!/usr/bin/env bash

# Ensure git is setup correctly locally
./setup.sh -s

CURRENT_BRANCH=`git branch | grep \* | awk '{print $2}'`
git push source ${CURRENT_BRANCH}