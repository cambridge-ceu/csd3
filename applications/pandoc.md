---
sort: 50
---

# pandoc

Web: [https://pandoc.org/](https://pandoc.org/)

We use this release: [https://github.com/jgm/pandoc/releases/tag/2.13](https://github.com/jgm/pandoc/releases/tag/2.13)

Some applications requires the more recent version than those from CSD3; it is straightforward to install.

## 3.6.2

Little has been changed on the way to install, but from 3.0 it uses its own --citeproc which would require higher version of texlive.

## 2.13

```bash
cd ${HPC_WORK}
wget -qO- https://github.com/jgm/pandoc/releases/download/2.13/pandoc-2.13-linux-amd64.tar.gz | tar xvfz - --strip-components=1
```

so that the executable file and documentation are made available from bin/ and share/ directories, respectively.

See citeproc for handling bibliography.

## pandoc-citeproc

Web: [https://hackage.haskell.org/package/pandoc-citeproc](https://hackage.haskell.org/package/pandoc-citeproc)

This has been replaced by citeproc but somewhat of interest.

```bash
wget -qO- https://hackage.haskell.org/package/pandoc-citeproc-0.17.0.2/pandoc-citeproc-0.17.0.2.tar.gz | \
tar xvfz -
cd pandoc-citeproc-0.17.0.2/
# install stack
wget -qO- https://get.haskellstack.org/ > stack.sh
## editing stack.sh to let DESTDIR=${HPC_WORK}
sh stack.sh -f
export CEUADMIN=/usr/local/Cluster-Apps/ceuadmin/pandoc-citeproc/0.17.0.2
module load cabal/3.2.0.0
cabal update
cabal build pandoc-citeproc.cabal
cabal install --installdir=${CEUADMIN}/bin \
              --enable-shared --enable-static --enable-executable-dynamic --enable-executable-static --install-method=copy --overwrite-policy=always
# GitHub counterpart has a makefile
# https://raw.githubusercontent.com/jgm/pandoc-citeproc/master/Makefile
make
```

The directories involves ${HOME}/.cabal or ${HOME}/.stack (which also include ghc 8.6.5) and `${HOME}/.local` when Makefile is used.
