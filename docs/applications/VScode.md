---
sort: 55
---

# Visual Studio code

Web: [https://code.visualstudio.com/](https://code.visualstudio.com/).

## Installation

Download and extract a copy for Linux x64, e.g., for the latest version 1.58.0,

```bash
cd ${HPC_WORK}
tar xvfz code-stable-x64-1625728370.tar.gz
ln -sf ${HPC_WORK}/VSCode-linux-x64/bin/code ${HPC_WORK}/bin/code
```

By default it requires `chrome-sandbox is owned by root and has mode 4755` which could be achieved at CSD3 by

```bash
sudo chown root:root chrome-sandbox
sudo chmod 4755 chrome-sandbox
```

Unfortunately, as ordinary users this is impossible and we use without this option.

## Execution

Start for reasons above,

```bash
code --no-sandbox
```

## Jupyter notebook

We could start our virtual environment as described in `hail`, e.g.,

```bash
cd ~/rds/results/public/gwas/ukb_exomes/tutorials
code --no-sandbox 01-genome-wide-association-study.ipynb &
```

which greatly simplifies the procedure as described for `genebass`. MAKE sure various extensions/options suggesed from the session.
