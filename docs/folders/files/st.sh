#!/usr/bin/bash

git add cardio
git commit -m "information on CEU's Cardio"
git add docs
git commit -m "docs"
git add files
git commit -m "copies of files"
git add README.md
git commit -m "README"
git add cardio.md
git commit -m "Information on Cardio"
git remote add origin git@github.com:cambridge-ceu/csd3.git
git add usage.md
git commit -m "Usage notes"
git add _config.yml
git commit -m "_config.yml"
git push -u origin master
