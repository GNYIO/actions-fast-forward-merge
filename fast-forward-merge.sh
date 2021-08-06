#!/bin/bash

echo "first argument: $1"
echo "second argument: $2"

echo "checking out $1"
git checkout $1

echo "printing all local branches..."
git branch --list

echo "checking if '$1' can be merged into '$2'"
git merge-base --is-ancestor $1 $2

if [[ $? -eq 0 ]]; then
  echo "merging (ff) '$1' -> '$2'"
  git merge $2
else
  echo "no ff (fast forward) merge is possible"
  exit 1
fi
