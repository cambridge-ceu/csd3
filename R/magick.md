---
sort: 15
---

# magick

> The magick package provide a modern and simple toolkit for image processing in R. It wraps the ImageMagick STL which is the most comprehensive open-source image processing library available today.

## 2.8.5

Module `ceuadmin/DjVuLibre` is used to recompile `ceuadmin/ImageMagick/7.1.1-31`; as before `install.packages("magick")` goes smoothly.

## 2.8.3/2.8.4

### gcc/8.5

This is now smoothly done with `install.packages("magick")` under icelake after `ceuadmin/ImageMagick/7.1.1-31` was recompiled.

The latter has `module load libpng/1.6.37/gcc/bkdpz5q4 libxml2/2.9.12/gcc/eizlvpgn ceuadmin/readline` in the module file.

### gcc/6

It is required for module `image-magick-7.0.5-9-gcc-5.4.0-d4lemcc`, coupling with C++11 via ~/.R/Makevars.

```
CC=gcc
CXX=g++ -std=gnu++11
PKG_CXXFLAGS= -std=c++11
CFLAGS = -std=c99 -I/usr/include -g -O2 -Wall -pedantic -mtune=native -Wno-ignored-attributes -Wno-deprecated-declarations -Wno-parentheses -Wimplicit-function-declaration
CXXFLAGS = -std=c++11
```

The setup is appropriate for module `ceuadmin/ImageMagick/7.1.1-31` with `src/Makevars` and a disabled `configure`,

```
PKG_CPPFLAGS=-fopenmp -DMAGICKCORE_HDRI_ENABLE=1 -DMAGICKCORE_QUANTUM_DEPTH=16 -DMAGICKCORE_CHANNEL_MASK_DEPTH=32 -I/usr/local/Cluster-Apps/ceuadmin/ImageMagick/7.1.1-31/include/ImageMagick-7
PKG_CXXFLAGS=$(C_VISIBILITY)
PKG_LIBS=-L/usr/local/Cluster-Apps/ceuadmin/ImageMagick/7.1.1-31/lib -lm -lMagick++-7.Q16HDRI -lMagickWand-7.Q16HDRI -lMagickCore-7.Q16HDRI

all:

clean:
	rm -f $(SHLIB) $(OBJECTS)
```

## 2.7.1

When installing the package we have error message,

```
> install.packages("magick")
Installing package into ‘/rds/user/jhz22/hpc-work/R’
(as ‘lib’ is unspecified)
trying URL 'https://cran.r-project.org/src/contrib/magick_2.7.1.tar.gz'
Content type 'application/x-gzip' length 4813079 bytes (4.6 MB)
==================================================
downloaded 4.6 MB

* installing *source* package ‘magick’ ...
** package ‘magick’ successfully unpacked and MD5 sums checked
** using staged installation
Package Magick++ was not found in the pkg-config search path.
Perhaps you should add the directory containing `Magick++.pc'
to the PKG_CONFIG_PATH environment variable
No package 'Magick++' found
Using PKG_CFLAGS=
Using PKG_LIBS=-lMagick++-6.Q16
--------------------------- [ANTICONF] --------------------------------
Configuration failed to find the Magick++ library. Try installing:
 - deb: libmagick++-dev (Debian, Ubuntu)
 - rpm: ImageMagick-c++-devel (Fedora, CentOS, RHEL)
 - csw: imagemagick_dev (Solaris)
 - brew imagemagick@6 (MacOS)
For Ubuntu versions Trusty (14.04) and Xenial (16.04) use our PPA:
   sudo add-apt-repository -y ppa:cran/imagemagick
   sudo apt-get update
   sudo apt-get install -y libmagick++-dev
If Magick++ is already installed, check that 'pkg-config' is in your
PATH and PKG_CONFIG_PATH contains a Magick++.pc file. If pkg-config
is unavailable you can set INCLUDE_DIR and LIB_DIR manually via:
R CMD INSTALL --configure-vars='INCLUDE_DIR=... LIB_DIR=...'
-------------------------- [ERROR MESSAGE] ---------------------------
<stdin>:1:22: fatal error: Magick++.h: No such file or directory
compilation terminated.
--------------------------------------------------------------------
ERROR: configuration failed for package ‘magick’
* removing ‘/rds/user/jhz22/hpc-work/R/magick’

The downloaded source packages are in
        ‘/tmp/RtmpI9BUec/downloaded_packages’
Warning message:
In install.packages("magick") :
  installation of package ‘magick’ had non-zero exit status
```

Although `which convert` and `which display` both point to `/usr/bin`,
it turned out that the required ImageMick needs to be loaded as follows,

```bash
module load image-magick-7.0.5-9-gcc-5.4.0-d4lemcc
```
