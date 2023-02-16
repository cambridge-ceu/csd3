---
sort: 16
---

# R/Rfast

For 2.0.4, we received the following error,

```
Error: C++17 standard requested but CXX17 is not defined
```

To proceed, we modify ~/.R/Makevars with the following line

```
CXX17 = g++ -std=gnu++17 -fPIC
```

We can get away with this,

```bash
module load gcc/6
Rscript -e "install.packages('Rfast')"
```
