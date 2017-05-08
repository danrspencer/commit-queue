#!/usr/bin/env bash

CURRENT=`git remote -v | grep fetch | head -n 1 | awk '{print $2}'`

# Sort out the remote urls
if [[ ${CURRENT} == *-pending.git ]]
then
    SOURCE=${CURRENT%????????????}.git
    PENDING=${CURRENT}
elif [[ ${CURRENT} == *-pending ]]
then
    SOURCE=${CURRENT%????????}
    PENDING=${CURRENT}
elif [[ ${CURRENT} == *.git ]]
then
    SOURCE=${CURRENT}
    PENDING=${SOURCE%????}-pending.git
else
    SOURCE=${CURRENT}
    PENDING=${SOURCE}-pending
fi

# Setup the local git config with the correct remotes
git remote rm origin &> /dev/null
git remote add origin ${SOURCE}
git config remote.origin.pushurl ${PENDING}

git remote rm source &> /dev/null
git remote add source ${SOURCE}

git remote rm pending &> /dev/null
git remote add pending ${PENDING}

if [[ $1 != "-s" ]]
then
    git remote -v
fi