#!/usr/bin/bash

function renum()
# grep sort -w *md  | sort -k2,2n
{
  echo ${1}
  export folder=${1}
  ls $1/*md  | \
  grep -v -e README -e files | sort | xargs -I {} basename {} .md | awk '{print NR,$1}' | \
  parallel -j1 -C' ' --env folder '
    echo {1} {2}
    export line=2
    export value={1}
    sed -i "${line}s/\S\+/${value}/2" ${folder}/{2}.md
  '
  head -3 $1/*md | grep sort | sort -k2,2n
}

function _packages()
{
  export dir=$1
  ls ${dir}/*md | grep -v -e README | sort | xargs -I {} basename {} .md | awk '{print NR,$1}' | \
  parallel -j1 --env dir -C' ' '
    echo {1} {2}
    export line=2
    export value={1}
    sed -i "${line}s/\S\+/${value}/2" ${dir}/{2}.md
  '
}

# bundle install
# bundle info jekyll-rtd-theme
# make install
# make theme

renum systems
renum applications
_packages Python
_packages R
make build

### Earlier experiment: https://readthedocs.org/projects/csd3/
### Earlier experiment: https://readthedocs.org/projects/csd3v2/

for f in $(ls -a)
do
   git add ${f}
   git commit -m "${f}"
done
git push
