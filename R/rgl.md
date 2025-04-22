---
sort: 28
---

# rgl

## 1.3.17

This compiles smoothly after `module load ceuadmin/libpng`.

## 1.1.3

The usual `install.package("rgl")` would fail with error message,

```
** testing if installed package can be loaded from temporary location
sh: line 1: 137528 Segmentation fault      R_TESTS= '/rds-d4/user/jhz22/hpc-work/R-4.3.0/bin/R' --no-save --no-restore --no-echo 2>&1 < '/rds/user/jhz22/hpc-work/work/RtmpSBVmUx/file2109c79080cd3'
ERROR: loading failed
```

We turn to a downloaded.package with `--no-test-load`, which is successful but fails to load. Running `R -d gdb` showing error with `gui.cpp`.

Next we disable OpenGL as follows,

```bash
R CMD INSTALL --configure-args="--disable-opengl" rgl_1.1.3.tar.gz
```

which again is successful and in an R session, we receive message

```
This build of rgl does not include OpenGL functions.  Use
 rglwidget() to display results, e.g. via options(rgl.printRglwidget = TRUE).
```

However, the web browser on CSD3 won't work and we turn to RStudio, e.g.,

```bash
module load ceuadmin/rstudio
```

and inside the R session we experiment with code,

```r
options(rgl.printRglwidget = TRUE)
open3d()
x <- sort(rnorm(1000))
y <- rnorm(1000)
z <- rnorm(1000) + atan2(x, y)
plot3d(x, y, z, col = rainbow(1000))
```

## 1.2.1

It compiles and loads smoothly.
