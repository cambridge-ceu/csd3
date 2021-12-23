---
sort: 8
---

# bgenix

Web: [https://enkre.net/cgi-bin/code/bgen/dir?ci=trunk](https://enkre.net/cgi-bin/code/bgen/dir?ci=trunk)

It is now possible to compile 1.1.7 under Python 3.x.

```bash
#!/usr/bin/bash
# get it
wget -qO- http://code.enkre.net/bgen/tarball/release/bgen.tgz | tar xvfz -
mv bgen.tgz bgenix
cd bgenix
# compile it
./waf configure
./waf
# test it
./build/test/unit/test_bgen
./build/apps/bgenix -g example/example.16bits.bgen -list
```

and we could set up appropriate symbolic links.
