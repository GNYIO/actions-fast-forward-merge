#!/bin/bash


echo "(1st) checking if remote branch '$1' exists"
DOES_FIRST_BRANCH_EXIST=$(git ls-remote --heads --quiet | tr '\t' ' ' | cut -d ' ' -f 2 | tr '/' ' ' | cut -d ' ' -f 3 | grep -w $1 | wc -l)

if [[ $DOES_FIRST_BRANCH_EXIST -ne 1 ]]; then
  echo "branch '$1' doesn't seem to exist on remote"
  exit 1
fi
echo "remote branch '$1' exists"
echo ""


echo "(2nd) checking if remote branch '$2' exists"
DOES_SECOND_BRANCH_EXIST=$(git ls-remote --heads --quiet | tr '\t' ' ' | cut -d ' ' -f 2 | tr '/' ' ' | cut -d ' ' -f 3 | grep -w $2 | wc -l)
if [[ $DOES_SECOND_BRANCH_EXIST -ne 1 ]]; then
  echo "branch '$2' doesn't seem to exist on remote"
  exit 1
fi
echo "remote branch '$2' exists"
echo ""


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
