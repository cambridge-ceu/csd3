---
sort: 10
---

# circos

Web: [http://circos.ca](http://circos.ca) ([Google group](https://groups.google.com/g/circos-data-visualization))

## Installation

```bash
wget -qO- http://www.circos.ca/distribution/circos-current.tgz | \
tar xvfz -
cd circos-0.69-9
bin/circos --modules
wget -qO- http://circos.ca/distribution/circos-tutorials-current.tgz | \
tar xvfz -
wget -qO- http://www.circos.ca/distribution/circos-tools-current.tgz | \
tar xvfz -
```

The following required Perl modules can be installed

```perl
Config::General (v2.50 or later)
Font::TTF
GD
List::MoreUtils
Math::Bezier
Math::Round
Math::VecStat
Params::Validate
Readonly
Regexp::Common
Set::IntSpan (v1.16 or later)
Text::Format
```

For instance, the Perl module DBI can be furnished with

```bash
sudo perl -MCPAN -e shell
install DBI
```

The [CircosAPI](https://github.com/kylase/CircosAPI) module requires `namespace::autoclean`, `Moose`, `JSON::PP` and `String::Util`.

## Examples

We can enter the example/ directory to run its script (`run`), which contains the following lines.

```bash
#!/bin/bash
echo "Creating image circos.png and writing report to run.out."
echo "Example takes ~45-60 seconds to generate."
../bin/circos -conf etc/circos.conf -debug_group summary,timer > run.out
```

where `run.out` holds the log.
