---
sort: 63
---

# Visual Studio code

Web: [https://code.visualstudio.com/](https://code.visualstudio.com/).

<font color="red"><b>24/2/2025 Update</b></font>

Module `ceuadmin/VSCode/1.97.2` is now available with Copilot.

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

## ceuadmin module

This is called with

```bash
module load ceuadmin/VSCode/1.76.2
```

which enables executation with relevant command-line arguments.

## Jupyter notebook

We could start our virtual environment as described in `hail`, e.g.,

```bash
cd ~/rds/results/public/gwas/ukb_exomes/tutorials
code --no-sandbox 01-genome-wide-association-study.ipynb &
```

which greatly simplifies the procedure as described for `genebass`. MAKE sure various extensions/options suggesed from the session.

## Markdown document

It will be displayed by design.

## CodeGPT

From Visual Studio Code, install CodeGPT.

Supply an API key from Open AI, <https://platform.openai.com/overview>, entered via `Ctrl-Shift-p` for `CodeGPT: Set API Key`.

Create a file such as `testCodeGPT.R` with comments `# I would like to draw a forest plot` and key in `Ctrl-Shift-i`.

Here is an example,

> \# Can I draw a Manhattan plot of GWAS

with answer below,

Yes, you can draw a Manhattan plot of GWAS in R using the `qqman` package.

Here's a sample code:

```R
# install and load the `qqman` package
install.packages("qqman")
library(qqman)

# read in the GWAS results file
gwas_results <- read.table("my_gwas_results.txt", header=T)

# specify the chromosome column
chr_col <- "CHR"

# specify the p-value column
pval_col <- "P_VALUE"

# draw the Manhattan plot
manhattan(gwas_results, chr=chr_col, p=pval_col)
```

Replace `"my_gwas_results.txt"` with the actual name of your GWAS results file. Also, make sure to specify the correct column names for chromosome and p-value in `chr_col` and `pval_col`, respectively.
