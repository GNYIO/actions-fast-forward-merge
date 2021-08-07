#!/bin/bash

echo "first argument: $1"
echo "second argument: $2"


echo "show git version"
git --version
echo ""

echo "checking out '$2'"
git checkout "$2"
echo ""

echo "printing all local branches..."
git branch -vv
echo ""

echo "checking if '$1' can be merged into '$2'"
git merge-base --is-ancestor $2 $1

if [[ $? -eq 0 ]]; then
  echo "merging (ff) '$1' -> '$2'"
  git merge $1
  git push origin $2
else
  echo "no ff (fast forward) merge is possible"
  exit 1
fi
