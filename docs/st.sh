#!/usr/bin/bash

make build

function renum()
{
  ls usages/*md | grep -v README | xargs -I{} basename {} .md | awk '{print NR,$1}' | \
  parallel -C' ' 'lineNumber=2 newValue={1} sed -i ${lineNumber} "s/\S\+/${newValue}/2" {2}'
}
