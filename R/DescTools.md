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
module load gcc/8
tar xvfz DescTools_0.99.52.tar.gz
sed -i '/LinkingTo/i\SystemRequirements: C++17' DescTools/DESCRIPTION
R CMD INSTALL DescTools
```

where file `DESCRIPTION` is modified adding `SystemRequirements: C++17` before the `LinkingTo` directive.

## 0.99.54

The much-needed statement `SystemRequirements: C++17` is now available from `DESCRIPTION`.

We see from `strings /usr/local/software/master/gcc/9/lib64/libstdc++.so.6.0.28 | grep GLIBCXX` that

```
GLIBCXX_3.4
GLIBCXX_3.4.1
GLIBCXX_3.4.2
GLIBCXX_3.4.3
GLIBCXX_3.4.4
GLIBCXX_3.4.5
GLIBCXX_3.4.6
GLIBCXX_3.4.7
GLIBCXX_3.4.8
GLIBCXX_3.4.9
GLIBCXX_3.4.10
GLIBCXX_3.4.11
GLIBCXX_3.4.12
GLIBCXX_3.4.13
GLIBCXX_3.4.14
GLIBCXX_3.4.15
GLIBCXX_3.4.16
GLIBCXX_3.4.17
GLIBCXX_3.4.18
GLIBCXX_3.4.19
GLIBCXX_3.4.20
GLIBCXX_3.4.21
GLIBCXX_3.4.22
GLIBCXX_3.4.23
GLIBCXX_3.4.24
GLIBCXX_3.4.25
GLIBCXX_3.4.26
GLIBCXX_3.4.27
GLIBCXX_3.4.28
```

however this is not the default library that gcc/9 is needed.

It is apparent that with it is impossible to get it work, so we recompile R under gcc/11 which does not need specification of C++17 from ~/R./Makevars.
