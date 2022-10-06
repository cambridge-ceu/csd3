---
sort: 37
---

# AlphaPept and PyOpenMS

The prerequisites involve CSD3 location, [GNU C](https://gcc.gnu.org/), [cmake](https://cmake.org/), [TeX Live](https://www.tug.org/texlive/) and [Miniconda](https://docs.conda.io/en/latest/miniconda.html).

### CSD3 location

This is set as follows,

```bash
export Caprion=/rds/project/jmmh2/rds-jmmh2-projects/Caprion_proteomics
cd ${Caprion}
```

### GNU C, cmake and Tex Live

A number of aspects are worthwhile to highlight:

1. OpenMS supports for`c++17`.
2. It also requires a recent version of cmake, which will recognise its associate directives [^python].
3. TeX Live is not essential for OpenMS to be functional but allows for documentation with pdfTeX -- additional packages are required [^tlmgr].
4. OpenMS requires somewhat earlier version of ghostscript which is actually available on CSD3 (GPL Ghostscript 9.25 (2018-09-13)) and we point to it via a symbolic link assuming ${HOME}/bin is on top of $PATH.

We have

```bash
module load gcc/7 cmake-3.19.7-gcc-5.4-5gbsejo texlive
ln -sf /usr/bin/ghostscript ${HOME}/bin/gs
```

In so doing `gsftopk ntx-Bold-tlf-t1 600`, etc. in the documentation building process will work. We obtain the much desired `OpenMS_tutorial/latex_output/refman.pdf` and [`OpenMS_tutorial.pdf`](files/OpenMS_tutorial.pdf).

### Miniconda

This option is considerably easier and we set up the latest version.

```bash
# Step 1. Install Miniconda3
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
"$(/rds/project/jmmh2/rds-jmmh2-projects/Caprion_proteomics/miniconda3/bin/conda shell.bash hook)"
conda config --set auto_activate_base false
# Step 2. Specify module-like environment
export LD_LIBRARY_PATH=${Caprion}/miniconda3/lib:${LD_LIBRARY_PATH}
export PATH=${Caprion}/miniconda3/bin:${PATH}
export INCLUDE=${Caprion}/miniconda3/include:${INCLUDE}
export PYTHONPATH=${Caprion}/miniconda3/lib/python3.9/site-packages:${PYTHONPATH}
```

Note that Python 3.9.12 is installed, and in all cases the current environtal variables are carried over.

Only Step 2 is necessary in later calls.

## AlphaPept

Web: [https://github.com/MannLabs/alphapept](https://github.com/MannLabs/alphapept) ([latest installer](https://github.com/MannLabs/alphapept/releases/latest)).

After loading the Miniconda environment, we proceed with

```bash
pip install "alphapept[stable,gui-stable]"
```

Script for testing is called `alphapept_test.py` [^benchmark] which takes the following arguments,

  Name | Description
-------|-----------------------------------------------------------------------
`alphapept_settings.yaml`| A configuratino file containing relevant information, e.g., paths and `n_processes`.
`szwk021704i19101xms1.raw`, `szwk021704i19101xms3.raw`, `szwk021704i19101xms5.raw` | Raw spectra
`2022-07-05-reviewed-contam-UP000005640.fasta` | Database of protein sequences: 

## pyOpenMS

Web: [https://pyopenms.readthedocs.io/en/latest/index.html](https://pyopenms.readthedocs.io/en/latest/index.html) 

### Miniconda installation

```bash
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda install -c openms pyopenms
```

so `python pyopenms_test.py` responses. Note that currently it uses Python 3.9.6 therefore a slight backtrack which could be remedied by compiling from OpenMS in the next section.

### OpenMS

Web: [https://www.openms.de/](https://www.openms.de/) ([Contributed software](https://abibuilder.cs.uni-tuebingen.de/archive/openms/contrib/source_packages/)) (GitHub, [https://github.com/OpenMS/OpenMS](https://github.com/OpenMS/OpenMS))

This procedure produces many efficient programs which are complementary to pyopenms.

```bash
cd ${Caprion}
git clone https://github.com/OpenMS/OpenMS
cd OpenMS
git submodule update --init contrib
mkdir -p contrib/archives
cd contrib/archives
wget -nd --execute="robots = off" --mirror --convert-links --no-parent --wait=5 \
     https://abibuilder.cs.uni-tuebingen.de/archive/openms/contrib/source_packages/
cd -
cmake -DBUILD_TYPE=ALL contrib
cmake -DOPENMS_CONTRIB_LIBS=${Caprion}/miniconda3/lib -DCMAKE_PREFIX_PATH=contrib -DPYOPENMS=ON ../OpenMS
make targets
```
The second `wget` statement is much more efficient to download all the files.

The last statement gives the most important targets for OpenMS, where TOPP refers to `The OpenMS Proteomics Pipeline`.

```
==========================================================================

The following make targets are available:
    [no target]     builds the OpenMS library, TOPP tools and UTILS tools
    OpenMS          builds the OpenMS library
    TOPP            builds the TOPP tools
    UTILS           builds the UTILS tools
    GUI             builds the GUI tools (TOPPView,...)
    test            executes OpenMS and TOPP tests
                    make sure they are built using the 'all' target
    Tutorials_build builds the code snippets of the tutorials in source/EXAMPLES
    doc             builds the doxygen and class documentation, parameters
                    documentation, and tutorial PDFs
    doc_class_only  builds only the doxygen and class documentation
                    (faster then doc and very useful when writing
                    documentation).
    doc_tutorials   builds the PDF tutorials
    help            list all available targets (very verbose)
    pyopenms           builds pyOpenMS inplace
    pyopenms_bdist_egg builds pyOpenMS bdist_egg
    pyopenms_bdist     builds pyOpenMS bdist as zip file
    pyopenms_rpm       builds pyOpenMS rpm

    (Disabled) OpenMS_coverage reporting target is not enabled (to enable use -D OPENMS_COVERAGE=ON).
               Caution: Building with debug and coverage info uses a lot of disk space (>40GB)


Single TOPP tools and UTILS have their own target, e.g. TOPPView

==========================================================================
```

Upon completion, the pyopenms package is within OpenMS/pyOpenMS. It would come handy to link bin/, lib/, etc. in the environmental variables accordingly; in particular pyOpenMS to PYTHONPATH.

Beside the codebase, various other options are possible, e.g.,

```bash
wget https://archive.apache.org/dist/xerces/c/3/sources/xerces-c-3.2.0.tar.gz -O Xerces-C_3_2_0.tar.gz
cmake -DOPENMS_CONTRIB_LIBS=${Caprion}/miniconda3/lib -DCMAKE_PREFIX_PATH=contrib -DMY_CXX_FLAGS="-std=c++17" -DWITH_GUI=OFF ../OpenMS
```

For a particular version without using GitHub, it is necessary to specify explicitly, e.g.,

```bash
cd ${Caprion}
export version=3.0.0
wget -qO- https://abibuilder.cs.uni-tuebingen.de/archive/openms/OpenMSInstaller/nightly/OpenMS-${version}-src.tar.gz | \
tar xfz -
cd ${Caprion}/OpenMS-${version}
mkdir -p contrib/archives
wget -nd --execute="robots = off" --mirror --convert-links --no-parent --wait=5 \
     https://abibuilder.cs.uni-tuebingen.de/archive/openms/contrib/source_packages/
cd -
cmake -DBUILD_TYPE=ALL contrib
cmake -DGIT_TRACKING=OFF -DENABLE_UPDATE_CHECK=OFF -DOPENMS_CONTRIB_LIBS=contrib \
      -DPYOPENMS=OFF -DOPENMS_COVERAGE=OFF ../OpenMS-${version}
```

---

## Legacy

As with instances elsewhere, this section is kept not only for historical reasons but also for some useful information.

Python itself is lightweight but more involved.

### Python

The installations involve environements for several versions of Python, e.g., Python 3.7/3.8.

```bash
module load python/3.7
virtualenv py37
source py37/bin/activate
```
or

```bash
module load python/3.8
virtualenv py38
source py38/bin/activate
```

Note the `virtualenv py3[7|8]` lines are unnecessary after the installations.

### Miniconda3

This is in regard to use of module on CSD3.

```bash
module load miniconda/3
conda create -n miniconda38 python=3.8 ipykernel
conda activate miniconda38
conda deactivate
```

where `conda create` is unnecessary in later calls.

### AlphaPept

This requires Python >= 3.8.

```bash
cd ${Caprion}
module load python/3.8
source py38/bin/activate
pip install pyyaml --prefix=${Caprion}/py38
pip install numba --prefix=${Caprion}/py38
pip install tqdm --prefix=${Caprion}/py38
pip install h5py --prefix=${Caprion}/py38
pip install fastcore --prefix=${Caprion}/py38
pip install psutil --prefix=${Caprion}/py38
pip install click --prefix=${Caprion}/py38
pip install Bio --prefix=${Caprion}/py38
pip install networkx --prefix=${Caprion}/py38
pip install sqlalchemy --prefix=${Caprion}/py38
pip install matplotlib --prefix=${Caprion}/py38
pip install sklearn --prefix=${Caprion}/py38
python -m pip install --upgrade numpy --user
wget -qO- https://github.com/MannLabs/alphapept/archive/refs/tags/v0.4.8.tar.gz | \
tar xvfz -
cd alphapept-0.4.8
python setup.py install --prefix=${Caprion}/py38
```

Be careful with conflicts of packages.

The newest features are through the nightly build/wheel (needs to be version 3.0+).

```bash
wget -qO- https://nightly.link/OpenMS/OpenMS/workflows/pyopenms-wheels/nightly/Linux-wheels.zip\?status\=completed
unzip Linux-wheels.zip\?status\=completed
```

We have

```
Archive:  Linux-wheels.zip?status=completed
 Length   Method    Size  Cmpr    Date    Time   CRC-32   Name
--------  ------  ------- ---- ---------- ----- --------  ----
96180971  Defl:N 95271735   1% 09-25-2022 00:41 37b53f6d  pyopenms_nightly-3.0.0.dev20220924-cp37-cp37m-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
76497352  Defl:N 75780910   1% 09-25-2022 00:41 63b654a1  pyopenms_nightly-3.0.0.dev20220924-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
56599302  Defl:N 56080139   1% 09-25-2022 00:41 86fa8bd7  pyopenms_nightly-3.0.0.dev20220924-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
--------          -------  ---                            -------
229277625         227132784   1%                            3 files
```

It turned out only the first file is approppriate on CSD3, so we proceeded with

```bash
module load python/3.7
source py37/bin/activate
pip install pyopenms_nightly-3.0.0.dev20220924-cp37-cp37m-manylinux_2_17_x86_64.manylinux2014_x86_64.whl --no-cache-dir  --prefix=${Caprion}/py37
```

However, a call to `python pyopenms_test.py` gave the following error messages,

```
3.0.0.dev20220924
Traceback (most recent call last):
  File "pyopenms_test.py", line 36, in <module>
    df = pd.read_pickle(pkl_input_filename)
  File "/rds/project/jmmh2/rds-jmmh2-projects/Caprion_proteomics/py37/lib/python3.7/site-packages/pandas/io/pickle.py", line 217, in read_pickle
    return pickle.load(handles.handle)  # type: ignore[arg-type]
ValueError: unsupported pickle protocol: 5
```

### pyOpenMS

As will become obvious, the addresses were random with a hybrid of integrated and manual compiling.

```bash
git clone https://github.com/OpenMS/OpenMS
cd OpenMS
git submodule update --init contrib
cmake -DBUILD_TYPE=list ../OpenMS/contrib
cmake -DBUILD_TYPE=ALL -DNUMBER_OF_JOBS=4 ../OpenMS/contrib
# https://sourceforge.net/projects/open-ms/files/contrib/
cd archives
wget https://src.fedoraproject.org/lookaside/pkgs/libsvm/libsvm-3.12.tar.gz/a1b1083fe69a4ac695da753f4c83ed42/libsvm-3.12.tar.gz
cmake -DBUILD_TYPE=LIBSVM
wget https://archive.apache.org/dist/xerces/c/3/sources/xerces-c-3.2.0.tar.gz -O Xerces-C_3_2_0.tar.gz
# manual build is necessary!
wget http://www.coin-or.org/download/source/CoinMP/CoinMP-1.8.3.tgz -O CoinMP-1.8.3-vs22.tar.gz
cmake -DBUILD_TYPE=COINOR
wget https://boostorg.jfrog.io/artifactory/main/release/1.78.0/source/boost_1_78_0.tar.gz
cmake -DBUILD_TYPE=BOOST
wget https://sources.libreelec.tv/mirror/sqlite/sqlite-autoconf-3150000.tar.gz
cmake -DBUILD_TYPE=SQLITE
wget https://sourceforge.net/projects/open-ms/files/contrib/WildMagic5.tar.gz
cmake -DBUILD_TYPE=WILDMAGIC
wget https://sourceforge.net/projects/kissfft/files/kissfft/v1_3_0/kiss_fft130.tar.gz -O kissfft-130.tar.gz
wget https://sourceforge.net/projects/open-ms/files/contrib/glpk-4.46.tar.gz
cmake -DBUILD_TYPE=GLPK
# https://www.hdfgroup.org/packages/hdf5-1105-source/#
cmake -DBUILD_TYPE=HDF5
wget https://zlib.net/fossils/zlib-1.2.11.tar.gz
cmake -DBUILD_TYPE=ZLIB
wget https://src.fedoraproject.org/repo/pkgs/bzip2/bzip2-1.0.5.tar.gz/3c15a0c8d1d3ee1c46a1634d00617b1a/bzip2-1.0.5.tar.gz
cmake -DBUILD_TYPE=BZIP2
wget https://gitlab.com/libeigen/eigen/-/archive/3.3.4/eigen-3.3.4.tar.gz
tar xvfz eigen-3.3.4.tar.gz
cd eigen-3.3.4
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=${Caprion}/OpenMS/contrib
make install
cd ${Caprion}/OpenMS
cmake -DOPENMS_CONTRIB_LIBS=contrib -DCMAKE_PREFIX_PATH=contrib -DCMAKE_INSTALL_PREFIX=${Caprion} ../OpenMS
```

Now pyOpenMS is compiled with the following scripts

```bash
cd ${Caprion}/OpenMS
module load python/3.8
source ${Caprion}/bin/activate
pip install setuptools  --prefix=${Caprion}/py38
pip install pip  --prefix=${Caprion}/py38
pip install autowrap  --prefix=${Caprion}/py38
pip install nose  --prefix=${Caprion}/py38
pip install numpy  --prefix=${Caprion}/py38
pip install wheel  --prefix=${Caprion}/py38
cmake -DPYOPENMS=ON
make pyopenms
```

Further information is available from cmake website [^python].

## References

Strauss, M.T., et al., AlphaPept, a modern and open framework for MS-based proteomics. bioRxiv, 2021: p. 2021.07.23.453379. [https://www.biorxiv.org/content/10.1101/2021.07.23.453379v1](https://www.biorxiv.org/content/10.1101/2021.07.23.453379v1).

Rost HL, et al., OpenMS: a flexible open-source software platform for mass spectrometry data analysis. Nat Meth. 2016; 13, 9: 741-748. doi:10.1038/nmeth.3959.

## Other URLs

* OpenMS, [SourceForge](https://sourceforge.net/projects/open-ms/); [GITTER](https://gitter.im/OpenMS/OpenMS), [wikiwand](https://www.wikiwand.com/en/OpenMS), [OpenSWATH](https://openswath.org/en/latest/).
* tlmgr, [tlmgr.pdf](https://tug.ctan.org/info/tlmgrbasics/doc/tlmgr.pdf), [Installing_Extra_Packages](https://en.wikibooks.org/wiki/LaTeX/Installing_Extra_Packages), [pkginstall](https://www.tug.org/texlive/pkginstall.html), [Rstudio query](https://community.rstudio.com/t/latex-language-package-installation-not-working/51596/3).

---

[^python]:

    The website [https://cmake.org/cmake/help/latest/module/FindPython.html](https://cmake.org/cmake/help/latest/module/FindPython.html) explains several options which appear unnecessary for cmake 3.19.

    ```bash
    export Python_LIBRARY_DIRS=${Caprion}/miniconda3/lib
    export Python_INCLUDE_DIR=${Caprion}/miniconda3/include
    export Python_EXECUTABLE=${Caprion}/miniconda3/bin/python
    ```

[^tlmgr]: tlmgr -- the TEX Live Manager

    The required `newtx`, `fontaxes` and `xtab` package can be installed as follows,

    ```bash
    tlmgr init-usertree
    tlmgr option repository ftp://tug.org/historic/systems/texlive/2015/tlnet-final --user-mode
    tlmgr install --user-mode newtx
    tlmgr install --user-mode fontaxes
    tlmgr install --user-mode xtab
    ```

    For instance `tlmgr info newtx` command gives the following information,

    ```
    package:     newtx
    category:    Package
    shortdesc:   Alternative uses of the TX fonts, with improved metrics
    longdesc:    The bundle splits txfonts.sty (from the TX fonts distribution) into two independent packages, newtxtext.sty and newtxmath.sty, each with fixes and enhancements. newtxmath's metrics have been re-evaluated to provide a less tight appearance, and to provide a libertine option that substitutes Libertine italic and Greek letter for the existing math italic and Greek glyphs, making a mathematics package that matches Libertine text quite well. newtxmath can also use the maths italic font provided with the garamondx package, thus offering a garamond-alike text-with- maths combination.
    installed:   Yes
    revision:    39072
    sizes:       doc: 865k, run: 7429k
    relocatable: Yes
    cat-version: 1.463
    cat-date:    2015-12-11 20:31:08 +0100
    cat-license: lppl1.3
    cat-topics:  font font-maths font-type1
    cat-related: minion2newtx
    collection:  collection-fontsextra
    ```

    See also [https://ctan.org/pkg/newtx](https://ctan.org/pkg/newtx). Also related is # Karl's Path SEarch Library WHICH (kpsewhich), e.g., `kpsewich tikz`.

[^benchmark]: Benchmark

    Download file from [Dropbox](https://www.dropbox.com/sh/lb0agu7q7yg6w3x/AAAX4ENfgVeAq841qglH9rxAa?dl=0).

    ```bash
    ln -s alphapept-0.4.8 alphapept
    unzip hpc_setup.zip
    ```

    which gives `alphapept_test.py` and `pyopenms_test.py` above along with data files.
