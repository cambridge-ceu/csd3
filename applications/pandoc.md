---
sort: 29
---

# pandoc

Web: [https://pandoc.org/](https://pandoc.org/)

We use this release: [https://github.com/jgm/pandoc/releases/tag/2.13](https://github.com/jgm/pandoc/releases/tag/2.13)

Some applications requires the more recent version than those from CSD3; it is straightforward to install.

```bash
cd ${HPC_WORK}
wget -qO- https://github.com/jgm/pandoc/releases/download/2.13/pandoc-2.13-linux-amd64.tar.gz | tar xvfz - --strip-components=1
```

so that the executable file and documentation are made available from bin/ and share/ directories, respectively.

See citeproc for handling bibliography.

## pandoc-citeproc

Web: [https://github.com/jgm/pandoc-citeproc](https://github.com/jgm/pandoc-citeproc)

This has been replaced by citeproc but somewhat of interest.

```bash
# install stack
wget -qO- https://get.haskellstack.org/ > stack.sh
```

then editing st.sh to let DEFAULT_DEST="/rds/user/jhz22/hpc-work/bin/stack" and run with bash. These are followed by

```bash
cd pandoc-citeproc-0.17.0.2
make
```

which installs stack-related files (2.3GB) into ${HOME}/.stack (which includes ghc 8.6.5) and pandoc-citeproc-0.17.0.2 to `/rds/user/jhz22/hpc-work/.local/` (22G).
