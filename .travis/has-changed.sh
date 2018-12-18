#!/bin/bash

if [[ -z $1 ]]; then
    echo "Commit range should not be empty"
    exit 1
fi

if [[ -z $2 ]]; then
    echo "Project path should not be empty"
    exit 1
fi

git diff --name-only $1 | uniq | grep -i $2 > /dev/null