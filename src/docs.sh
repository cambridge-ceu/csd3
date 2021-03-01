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

cd docs
renum
make build
cd -

### Earlier experiment: https://readthedocs.org/projects/csd3/
### Earlier experiment: https://readthedocs.org/projects/csd3v2/
