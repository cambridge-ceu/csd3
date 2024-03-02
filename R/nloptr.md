---
sort: 14
---

# nloptr

## NLopt

Web: [https://nlopt.readthedocs.io/en/latest/](https://nlopt.readthedocs.io/en/latest/) ([GitHub](https://github.com/stevengj/nlopt))

This relates to pre-installation of `NLopt` though should be applicable to `R/nloptr` itself.

We download the latest NLopt according to [https://nlopt.readthedocs.io/en/latest/](https://nlopt.readthedocs.io/en/latest/), notably

```bash
wget -qO- https://github.com/stevengj/nlopt/archive/v2.7.1.tar.gz | \
tar xvfz -
cd nlopt-2.7.1/
cmake -DCMAKE_INSTALL_PREFIX=${HPC_WORK} .
make
make install
```

Additional options are available from its homepage.

## R/nloptr

Within R, we have seen error messages from `install.packages("nloptr")`,

```
test-C-API.cpp:108:35: error: call of overloaded 'abs(__gnu_cxx::__alloc_traits<std::allocator<double> >::value_type)' is ambiguous
     expect_true(abs(res[1] - 8./27) < 1.0e-4);
```

so we manually proceed with

```bash
Rscript -e 'download.packages("nloptr",".")'
tar xfz nloptr_2.0.0.tar.gz
cd nloptr
confiugre
```

We then do several things,

- rename `configure` to be `configure.save`.
- modify `src/Makevars` to point to -L${HPC_WORK}/lib64 to enable `-lnlopt`, so it becomes
  ```
  CXX_STD = CXX11
  PKG_CPPFLAGS = -I../inst/include -I/rds/user/jhz22/hpc-work/include
  PKG_LIBS = $(LAPACK_LIBS) $(BLAS_LIBS) $(FLIBS) -L/rds/user/jhz22/hpc-work/lib64 -lnlopt
  ```
- change `src/test-C-API.cpp` such that `abs()` there turns into `fabs()`.

We now can furnish the installation with

```bash
R CMD INSTALL nloptr
```
