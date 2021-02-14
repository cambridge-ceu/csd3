#!/usr/bin/bash

# git remote add origin git@github.com:cambridge-ceu/csd3.git
git add docs
git commit -m "docs"
git add src
git commit -m "commands"
git add README.md
git commit -m "README"
git add usage.md
git commit -m "Usage notes"
git push -u origin master
