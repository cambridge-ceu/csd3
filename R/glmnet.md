---
sort: 6
---

# glmnet

Web: [https://glmnet.stanford.edu/](https://glmnet.stanford.edu/).

### 4.1-3

The 'install.packages("glmnet")' command under R 4.1.3 gave the following error,

```
elnet_exp.cpp:141:59:   required from here
glmnetpp/include/glmnetpp_bits/elnet_point/gaussian_base.hpp:90:39: error: 'self' was not declared in this scope
                     [=](auto k) { self().template update<update_type::partial>(k, ab, dem); },
```

### Bash

We now proceed manually,

```bash
Rscript -e 'download.packages("glmnet",".")'
tar tvfz glmnet_4.1-3.tar.gz
```

and then modify `src/glmnetpp/include/glmnetpp_bits/elnet_point/gaussian_base.hpp` line 90[^1][^2][^3] as follows,

```cpp
                     [=](auto k) {this -> self().template update<update_type::partial>(k, ab, dem); }
```

and similarly line 55.

Our final step is then

```bash
R CMD INSTALL glmnet
```

## 4.1-4

### login node

It requires C++14, so we proceed with

```bash
echo "CXX14 = g++ -std=gnu++14 -fPIC" > ~/.R/Makevars
module load gcc/7
Rscript -e 'install.packages("glmnet")'
```

## 4.1-7

Released on 23/3/2023, it requires C++17 so the Makevars as above becomes

```bash
CXX17 = g++ -std=gnu++17 -fPIC
```

## 4.1-8

Besides ~/.R/Makevars, the following is necessary

```bash
module switch gcc/7
```

### icelake

#### Latest information

After software update on 27/4/2022, the R 4.2.0 installed from login nodes also works nicely with glmnet installed there.

#### R/4.1.0-icelake

The Matrix package is also required to recompile.

```bash
module load R/4.1.0-icelake
wget https://cran.r-project.org/src/contrib/Matrix_1.4-1.tar.gz
wget https://cran.r-project.org/src/contrib/glmnet_4.1-4.tar.gz
R CMD INSTALL Matrix_1.4-1.tar.gz
R CMD INSTALL glmnet_4.1-4.tar.gz
R CMD INSTALL Matrix_1.4-1.tar.gz -l .
```

so that the Matrix package is installed first to get going with glmnet but then made available locally to avoid conflict with the login nodes.

```r
library(Matrix,lib.loc=".")
library(glmnet)
```

The Matrix package is then reinstalled from the usual login node.

---

[^1]: This will be changed at the next release of glmnet.
[^2]: See [https://www.geeksforgeeks.org/this-pointer-in-c/](https://www.geeksforgeeks.org/this-pointer-in-c/) for information on the `this` operator.
[^3]: [C++ 2.0 new features -- lambda expressions](https://www.toutiao.com/a7074199269015912990/?channel=&source=search_tab&wid=1647161616813).
