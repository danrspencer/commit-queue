#!/usr/bin/env bash

BRANCH=`git branch | grep \* | awk '{print $2}'`

git push original ${BRANCH}

