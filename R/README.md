---
sort: 5
---

# R packages

source: `{{ page.path }}`

Here is a list of (well, most likely to be difficult to install/update) R packages.

As noted elsewhere, most packages are compiled under `gcc/6` -- at time of writing this is gcc 6.5.0. Most likely packages will be compiled given C++17, which is furnished with `~/.R/Makevars` containing the following lines.

```
CXX17 = g++ -std=gnu++17 -fPIC
```

Occasionally, package(s) such as `glmnet` will indicate this, a practice that facilitates installation greatly.

{% include list.liquid all=true %}

:star: **[R website](https://www.r-project.org/)**
