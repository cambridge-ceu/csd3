---
sort: 6
---

# bgenix

It is now possible to compile 1.1.7 under Python 3.x.

```bash
#!/usr/bin/bash
# get it
wget -qO- http://code.enkre.net/bgen/tarball/release/bgen.tgz | tar xvfz -
cd bgen.tgz
# compile it
./waf configure
./waf
# test it
./build/test/unit/test_bgen
./build/apps/bgenix -g example/example.16bits.bgen -list
```

and we could set up appropriate symbolic links.
