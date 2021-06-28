#!/usr/bin/bash

function renum()
{
  ls applications/*md | grep -v -e README -e files | sort | xargs -I {} basename {} .md | awk '{print NR,$1}' | \
  parallel -j1 -C' ' '
    echo {1} {2}
    export line=2
    export value={1}
    sed -i "${line}s/\S\+/${value}/2" applications/{2}.md
  '
}

module load gcc/6
# bundle install
# bundle info jekyll-rtd-theme
# make install
# make theme

cd docs
renum
make build
cd -

### Earlier experiment: https://readthedocs.org/projects/csd3/
### Earlier experiment: https://readthedocs.org/projects/csd3v2/

git add docs
git commit -m "docs"
git add src
git commit -m "commands"
git add README.md
git commit -m "README"
git push
