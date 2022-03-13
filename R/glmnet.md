---
sort: 3
---

# R/glmnet

Web: [https://glmnet.stanford.edu/](https://glmnet.stanford.edu/).

## R

The 'install.packages("glmnet")' for version 4.1-3 gave the following error,

```
elnet_exp.cpp:141:59:   required from here
glmnetpp/include/glmnetpp_bits/elnet_point/gaussian_base.hpp:90:39: error: 'self' was not declared in this scope
                     [=](auto k) { self().template update<update_type::partial>(k, ab, dem); },
```

## Bash

We now proceed manually,

```bash
Rscript -e 'download.packages("glmnet",".")'
tar tvfz glmnet_4.1-3.tar.gz
```

and then modify `src/glmnetpp/include/glmnetpp_bits/elnet_point/gaussian_base.hpp` line 90[^1,][^2,][^3] as follows,

```cpp
                     [=](auto k) {this -> self().template update<update_type::partial>(k, ab, dem); }
```

and similarly line 55.

Our final step is then

```bash
R CMD INSTALL glmnet
```

[^1]: This will be changed at the next release of glmnet.
[^2]: See [https://www.geeksforgeeks.org/this-pointer-in-c/](https://www.geeksforgeeks.org/this-pointer-in-c/) for information on the this operator.
[^3]: [C++ 2.0 new features -- lambda expressions](https://www.toutiao.com/a7074199269015912990/?channel=&source=search_tab&wid=1647161616813).
