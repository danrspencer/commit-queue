#!/usr/bin/env bash

ORIGINAL=`git remote -v | grep fetch | head -n 1 | awk '{print $2}'`

if [[ ${ORIGINAL} == *.git ]]
then
    PENDING=${ORIGINAL%????}-pending.git
else
    PENDING=${ORIGINAL}-pending
fi

git remote rm origin &> /dev/null
git remote add origin ${ORIGINAL}
git config remote.origin.pushurl ${PENDING}

git remote rm original &> /dev/null
git remote add original ${ORIGINAL}

git remote -v