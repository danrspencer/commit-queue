#!/usr/bin/env bash

# Ensure git is setup correctly locally
./setup.sh -s

BRANCH=`git branch | grep \* | awk '{print $2}'`

echo "Fetching source/$BRANCH:"
git fetch source
BAD_COMMITS=`git cherry source/${BRANCH} | awk '{print $2}'`

for COMMIT in "${BAD_COMMITS[@]}"
do
   :
   echo "git rebase -p --onto ${COMMIT}^ ${COMMIT}"
done