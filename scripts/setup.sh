#!/usr/bin/env bash

CURRENT=`git remote -v | grep fetch | head -n 1 | awk '{print $2}'`

if [[ ${CURRENT} == *-pending.git ]]
then
    ORIGINAL=${CURRENT%????????????}.git
    PENDING=${CURRENT}
elif [[ ${CURRENT} == *-pending ]]
then
    ORIGINAL=${CURRENT%????????}
    PENDING=${CURRENT}
elif [[ ${CURRENT} == *.git ]]
then
    ORIGINAL=${CURRENT}
    PENDING=${ORIGINAL%????}-pending.git
else
    ORIGINAL=${CURRENT}
    PENDING=${ORIGINAL}-pending
fi

git remote rm origin &> /dev/null
git remote add origin ${ORIGINAL}
git config remote.origin.pushurl ${PENDING}

git remote rm original &> /dev/null
git remote add original ${ORIGINAL}

git remote -v