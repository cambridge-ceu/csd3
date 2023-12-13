---
sort: 6
---

# Software

## ceuadmin

See [https://cambridge-ceu.github.io/csd3/systems/ceuadmin.html](https://cambridge-ceu.github.io/csd3/systems/ceuadmin.html) for additional information.

## gcc

It is one of the critical software to use, e.g.,

```bash
module avail gcc
gcc --version
```

With `module load gcc/8` we could compile this Timsort program.

```c
#include <stdio.h>

#define MIN_RUN 32

// 插入排序算法
void insertionSort(int arr[], int left, int right) {
    for (int i = left + 1; i <= right; i++) {
        int key = arr[i];
        int j = i - 1;
        while (j >= left && arr[j] > key) {
            arr[j + 1] = arr[j];
            j--;
        }
        arr[j + 1] = key;
    }
}

// 归并函数
void merge(int arr[], int left, int mid, int right) {
    int len1 = mid - left + 1;
    int len2 = right - mid;
    int L[len1], R[len2];

    for (int i = 0; i < len1; i++)
        L[i] = arr[left + i];
    for (int j = 0; j < len2; j++)
        R[j] = arr[mid + 1 + j];

    int i = 0, j = 0, k = left;

    while (i < len1 && j < len2) {
        if (L[i] <= R[j])
            arr[k++] = L[i++];
        else
            arr[k++] = R[j++];
    }

    while (i < len1)
        arr[k++] = L[i++];
    while (j < len2)
        arr[k++] = R[j++];
}

// Timsort 算法
void timSort(int arr[], int n) {
    for (int i = 0; i < n; i += MIN_RUN)
        insertionSort(arr, i, (i + MIN_RUN - 1) < n ? (i + MIN_RUN - 1)
                      : (n - 1));

    for (int size = MIN_RUN; size < n; size *= 2) {
        for (int left = 0; left < n; left += 2 * size) {
            int mid = left + size - 1;
            int right = (left + 2 * size - 1) < (n - 1) ?
              (left + 2 * size - 1) : (n - 1);
            merge(arr, left, mid, right);
        }
    }
}

int main() {
    int arr[] = {12, 11, 13, 5, 6, 7};
    int n = sizeof(arr) / sizeof(arr[0]);
    printf("Original array: ");
    for (int i = 0; i < n; i++)
        printf("%d ", arr[i]);

    timSort(arr, n);

    printf("\nSorted array: ");
    for (int i = 0; i < n; i++)
        printf("%d ", arr[i]);
    return 0;
}
```

by `gcc timsort.c -o timsort` and `timsort` to get

```
Original array: 12 11 13 5 6 7
Sorted array: 5 6 7 11 12 13 14:40
```

## gfortran

```bash
gfortran --version
```

## ghc

The Glasgow Haskell Compiler is seen from `module avail ghc`, e.g.,

```bash
module load ghc/8.2.2
ghc --version
```

## git

The popular git can be loaded,

```bash
git --help
git add --help
```

## Go

It is avail from `/usr/bin/go` and also visiable from `module avail go`.

## Java

```bash
module avail openjdk
java -version
```

## Julia

The Julia compiler is visible from `module avail julia`, and by default it loads 1.6.2

```bash
module load gcc/9 julia
julia --version
```

Here is the "hello, world!" session,

```
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.6.2 (2021-07-14)
 _/ |\__'_|_|_|\__'_|  |
|__/                   |

julia> println("Hello World")
Hello World

julia>
```

## libraOffice

Official website: [https://www.libreoffice.org/](https://www.libreoffice.org/)

The executables (`oocalc`, `ooffice`, `ooimpress`, `oomath`, `ooviewdoc`, `oowriter`) are in the `/usr/bin` directory and can be conveniently called from the console, e.g.,

```bash
oowriter README.docx
```

to load the Word document.

## matlab

Official website: [https://www.mathworks.com/products/matlab.html](https://www.mathworks.com/products/matlab.html).

```bash
module avail matlab
module load matlab/r2019b
```

followed by `matlab`.

## MySQL

One could access databases elsewhere, e.g., at UCSC -- see examples on VEP.

> There isn't any MySQL cluster running as a general service on CSD3. Do you believe your group has something running on a VM hosted on our network possibly? If you need a database for your work, running it in your own department and then allowing access to it from CSD3. Databases are not suitable candidates to run on a HPC cluster, the resource requirements are different and by definition they need to be running continuously whilst access is required, so wouldn't be run via SLURM for example.

## pspp

Official website: [https://www.gnu.org/software/pspp/](https://www.gnu.org/software/pspp/)

```bash
module load ceuadmin/pspp
```

with command-line tool `pspp` and a GUI counterpart `psppire`.

## Python

Official website: [https://www.python.org/](https://www.python.org/).

This can be invoked from a CSD3 console via `python` and `python3`. Libraries can be installed via `pip` and `pip3` (or equivalently `python -m pip install` and `python3 -m pip install`), e.g., the script

```bash
pip install mygene --user
pip install tensorflow --user
pip install keras --user
pip install jupyter --user
```

installs libraries at `$HOME/.local`. To install package to a specific directory, use the `--target=` (or `--install-option="--prefix=$PREFIX_PATH"`) option and flag in PYTHONPATH environmental variable.

Recent version of packages such as fastapi-0.104.1 would complain about lack of `setup.py` but one can get around with `pip install .` which uses its `pyproject.toml`.

It is advised to use virual environments, i.e.,

```bash
# inherit system-wide packages as well
module load python/3.5
virtualenv --system-site-packages py35
source py35/bin/activate
# pip new packages
deactivate
```

An alternative syntax is `python3 -m venv py37`

Note that when this is set up, one only needs to restart from the `source` command. The `pip` is appropriate for installing small number of package; otherwise Anaconda ([https://www.anaconda.com/](https://www.anaconda.com/)) and Jupyter notebook ([https://jupyter.org/](https://jupyter.org/)) are useful.

We first load Anaconda and create virtual environments,

```bash
module avail miniconda
module load miniconda/2
conda create -n py27 python=2.7 ipykernel
source activate py27
```

for Python 2.7 at `/home/$USER/.conda/envs/py27`, where envs could be replaced with the `--prefix` option. These are only required once.

We can also load Anaconda and activate Python 3.5[^venv],

```bash
module load miniconda/3
conda create -n py35 python=3.5 ipykernel
source activate py35
```

and follow [Autoencoder in Keras tutorial](https://www.datacamp.com/community/tutorials/autoencoder-keras-tutorial) on
data from [http://yann.lecun.com/exdb/mnist/](http://yann.lecun.com/exdb/mnist/)

The Jupyter notebook can be started as follows,

```bash
hostname
$HOME/.local/bin/jupyter notebook --ip=127.0.0.1 --no-browser --port 8081
```

If it fails to assign the port number, let the system choose (by dropping the `--port` option). The process which use the port can be shown with `lsof -i:8081` or stopped by `lsof -ti:8081 | xargs kill -9`. The command `hostname` gives the name of the node. Once the port number is assigned, it is
used by another ssh session _elsewhere_ and the URL generated openable from a browser, e.g.,

```bash
ssh -4 -L 8081:127.0.0.1:8081 -fN <hostname>.hpc.cam.ac.uk
firefox <URL> &
```

paying attention to the port number as it may change.

An `hello world` example is [hello.ipynb](files/hello.ipynb) from which [hello.html](files/hello.html) and [hello.pdf](files/hello.pdf) were generated with `jupyter nbconvert --to html|pdf hello.ipynb`.

See also <https://docs.hpc.cam.ac.uk/hpc/software-tools/python.html#using-anaconda-python> and <https://docs.hpc.cam.ac.uk/hpc/software-packages/jupyter.html>.

See [HPC docuementation](https://docs.hpc.cam.ac.uk/hpc/) for additional information on PyTorch, Tensorflow and GPU.

:star: **[Introduction to HPC in Python](https://www.hpc-carpentry.org/hpc-python/) ([GitHub](https://github.com/hpc-carpentry/hpc-python/)).**

## R

Official website: [https://www.r-project.org/](https://www.r-project.org/) and also [https://bioconductor.org/](https://bioconductor.org/).

Under HPC, the default version is 3.3.3 with /usr/bin/R; alternatively choose the desired version of R from

```bash
module avail R
module avail r
# if you would also like to use RStudio
module avail rstudio
```

e.g., `module load r-3.6.0-gcc-5.4.0-bzuuksv rstudio/1.1.383`.

For information about Bioconductor installation, see [https://bioconductor.org/install/](https://bioconductor.org/install/).

### Package installation

The following code installs package for weighted correlation network analysis ([WGCNA](https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/)).

```r
# from CRAN
dependencies <- c("matrixStats", "Hmisc", "splines", "foreach", "doParallel",
                  "fastcluster", "dynamicTreeCut", "survival")
install.packages(dependencies)
# from Bioconductor
biocPackages <- c("GO.db", "preprocessCore", "impute", "AnnotationDbi")
# R < 3.5.0
source("http://bioconductor.org/biocLite.R")
biocLite(biocPackages)
# R >= 3.5.0
install.packages("BiocManager")
BiocManager::install(biocPackages)
install.packages("WGCNA")
```

A good alternative is to use `remotes` or `devtools` package, e.g.,

```r
remotes::install_bioc("snpStats")
```

A separate example is from r-forge, e.g.,

```r
rforge <- "http://r-forge.r-project.org"
install.packages("estimate", repos=rforge, dependencies=TRUE)
```

In case of difficulty it is still useful to install directly, e.g.,

```bash
wget http://master.bioconductor.org/packages//2.10/bioc/src/contrib/ontoCAT_1.8.0.tar.gz
R CMD INSTALL ontoCAT_1.8.0.tar.gz
# Alternatively,
R -e "install.packages('ontoCAT_1.8.0.tar.gz',repos=NULL)"
```

The package installation directory can be spefied explicitly with R_LIBS, i.e.,

```bash
export R_LIBS=/rds/user/$USER/hpc-work/R:/rds/user/$USER/hpc-work/R-3.6.1/library
```

To upgrade Bioconductor, we can specify as follows,

```r
BiocManager::install(version = "3.14")
```

### Integration with Rcpp

Template-Rcpp, <https://github.com/stsds/Template-Rcpp> (LinkedIn [post](https://www.linkedin.com/feed/update/urn:li:activity:7136774813066358785/))

## ruby

```bash
module load ceuadmin/ruby
ruby --version
```

## Rust

```bash
module load ceuadmin/rust
rustc --version
```

## SLURM

Due to increase of size, the entry is moved here, <https://cambridge-ceu.github.io/csd3/systems/ParallelComputing.html>.

## Stata

Official website: [https://www.stata.com/](https://www.stata.com/).

As a CEU member the following is possible,

```
module load ceuadmin/stata/14
```

as with `ceuadmin/stata/15`. The meta-analysis (metan) and Mendelian Randomisation (mrrobust) packages can be installed as follows,

```stata
ssc install metan
net install mrrobust, from("https://raw.github.com/remlapmot/mrrobust/master/") replace
```

[^venv]: The following error

    ```
    CustomValidationError: Parameter channel_priority = 'flexible' declared in <<merged>> is invalid.
    The value 'flexible' cannot be boolified.
    ```

    can be resolved with `conda config --set channel_priority false`.
