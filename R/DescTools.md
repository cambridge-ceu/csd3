---
sort: 3
---

# DescTools

Web: <https://andrisignorell.github.io/DescTools/>

### 0.99.52

This version requires R>=4.3.0.

By default, gcc/9 uses C++14, i.e., `/usr/local/software/archive/linux-scientific7-x86_64/gcc-9/gcc-9.3.0-qszxcci5frtw4aul3m44oarpvxzyrgpp/bin/g++ -std=gnu++14 `

```
aux_fct.cpp: In function 'long long int compute_LCM(long long int, long long int)':
aux_fct.cpp:48:10: error: 'lcm' is not a member of 'std'
   48 |     std::lcm(a,b);
      |          ^~~
aux_fct.cpp: In function 'long long int compute_GCD(long long int, long long int)':
aux_fct.cpp:54:10: error: 'gcd' is not a member of 'std'
   54 |     std::gcd(a,b);
      |          ^~~
make: *** [aux_fct.o] Error 1
ERROR: compilation failed for package ‘DescTools’
* removing ‘/rds/project/jmmh2/rds-jmmh2-public_databases/software/R/DescTools’
```

which indicates that C++17 is required; it turns out specification via `.R/Makevars` is insufficient and we proceed with

```bash
module lost gcc/8
tar xvfz DescTools_0.99.52.tar.gz
sed -i '/LinkingTo/i\SystemRequirements: C++17' DescTools/DESCRIPTION
R CMD INSTALL DescTools
```

where file `DESCRIPTION` is modified adding `SystemRequirements: C++17` before the `LinkingTo` directive.
