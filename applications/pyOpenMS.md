---
sort: 37
---

# AlphaPept and PyOpenMS

## GNU C

The location at CSD3 is set as follows,

```bash
export Caprion=/rds/project/jmmh2/rds-jmmh2-projects/Caprion_proteomics/
cd ${Caprion}
module load gcc/7
```

where `gcc/7` specified though `gcc/6` appears to work well.

## Python

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

## AlphaPept

Web: [https://github.com/MannLabs/alphapept](https://github.com/MannLabs/alphapept) ([latest installer](https://github.com/MannLabs/alphapept/releases/latest)).

This requires Python >= 3.8.

```bash
module load python/3.8
cd ${Caprion}
source py38/bin/activate
python -mpip install pyyaml --prefix=${Caprion}/py38
python -mpip install numba --prefix=${Caprion}/py38
python -mpip install tqdm --prefix=${Caprion}/py38
python -mpip install h5py --prefix=${Caprion}/py38
python -mpip install fastcore --prefix=${Caprion}/py38
python -mpip install psutil --prefix=${Caprion}/py38
python -mpip install click --prefix=${Caprion}/py38
python -mpip install Bio --prefix=${Caprion}/py38
python -mpip install networkx --prefix=${Caprion}/py38
python -mpip install sqlalchemy --prefix=${Caprion}/py38
# matplotlib might need --user option
python -mpip install matplotlib --prefix=${Caprion}/py38
python -mpip install sklearn --prefix=${Caprion}/py38
wget -qO- https://github.com/MannLabs/alphapept/archive/refs/tags/v0.4.8.tar.gz | \
tar xvfz -
cd alphapept-0.4.8
python setup.py install --prefix=${Caprion}/py38
```

Script for testing is called `alphapept_test.py` [^benchmark] which takes the following arguments,

  Name | Description
-------|-----------------------------------------------------------------------
`alphapept_settings.yaml`| A configuratino file containing relevant information, e.g., paths and `n_processes`.
`szwk021704i19101xms1.raw`, `szwk021704i19101xms3.raw`, `szwk021704i19101xms5.raw` | Raw spectra
`2022-07-05-reviewed-contam-UP000005640.fasta` | Database of protein sequences: 

## pyOpenMS

Web: [https://pyopenms.readthedocs.io/en/latest/index.html](https://pyopenms.readthedocs.io/en/latest/index.html) 

The newest features are through the nightly build/wheel (needs to be version 3.0+).

```bash
wget -qO- https://nightly.link/OpenMS/OpenMS/workflows/pyopenms-wheels/nightly/Linux-wheels.zip\?status\=completed
unzip Linux-wheels.zip\?status\=completed
```

It turned out only the first file in the zip downloads
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

is approppriate on CSD3. Our first attempt then proceeded with

```bash
module load python/3.7
source py37/bin/activate
pip install pyopenms_nightly-3.0.0.dev20220924-cp37-cp37m-manylinux_2_17_x86_64.manylinux2014_x86_64.whl --no-cache-dir  --prefix=${Caprion}/py37
```

and a call to `python pyopenms_test.py` gave the following error messages,

```
3.0.0.dev20220924
Traceback (most recent call last):
  File "pyopenms_test.py", line 36, in <module>
    df = pd.read_pickle(pkl_input_filename)
  File "/rds/project/jmmh2/rds-jmmh2-projects/Caprion_proteomics/py37/lib/python3.7/site-packages/pandas/io/pickle.py", line 217, in read_pickle
    return pickle.load(handles.handle)  # type: ignore[arg-type]
ValueError: unsupported pickle protocol: 5
```

We turned to **Miniconda** below. We set out for the latest version, which is more desirable than those at CSD3,

```bash
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${Caprion}/miniconda3/lib
export PATH=${Caprion}/miniconda3/bin:${PATH}
export include=${Caprion}/miniconda3/include
module load python/3.8
conda update -n base -c defaults conda
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda install pandas
conda install -c openms pyopenms
```

so `python pyopenms_test.py` responsed.

### OpenMS

Web: ([https://github.com/OpenMS/OpenMS](https://github.com/OpenMS/OpenMS)) (older, [SourceForge](https://sourceforge.net/projects/open-ms/); [GITTER](https://gitter.im/OpenMS/OpenMS), [wikiwand](https://www.wikiwand.com/en/OpenMS)).

Contributed software: [https://abibuilder.cs.uni-tuebingen.de/archive/openms/contrib/source_packages/](https://abibuilder.cs.uni-tuebingen.de/archive/openms/contrib/source_packages/)

This involves a lot of contributed software, which needs to obtain manually [^contrib]. Nevertheless, it would allow for more flexible options.

```bash
git clone https://github.com/OpenMS/OpenMS
cd OpenMS
git submodule update --init contrib
cd contrib
cmake -DBUILD_TYPE=LIST ../OpenMS/contrib
cmake -DBUILD_TYPE=ALL -DNUMBER_OF_JOBS=4 ../OpenMS/contrib
# https://sourceforge.net/projects/open-ms/files/contrib/
cd archives
wget https://src.fedoraproject.org/lookaside/pkgs/libsvm/libsvm-3.12.tar.gz/a1b1083fe69a4ac695da753f4c83ed42/libsvm-3.12.tar.gz
cmake -DBUILD_TYPE=LIBSVM
wget https://archive.apache.org/dist/xerces/c/3/sources/xerces-c-3.2.0.tar.gz -O Xerces-C_3_2_0.tar.gz
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
cmake -DPYOPENMS=OFF
```

There were issues with COIN, GLPK, WM5 and a temporary fix was to comment on them in `cmake/cmake_findExternalLibs.cmake`.

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

We can fiddle around various command-line options, e.g., 

```bash
cmake -DOPENMS_CONTRIB_LIBS="../OpenMS/contrib/lib" -DBOOST_USE_STATIC=ON ../OpenMS
cmake -DCMAKE_PREFIX_PATH=${Caprion} -DBOOST_USE_STATIC=ON
export PYTHONPATH=${Caprion}/py38/lib/python3.8/site-packages
cmake -DOPENMS_CONTRIB_LIBS="../OpenMS/contrib/lib" -DBOOST_USE_STATIC=ON -DWITH_GUI=OFF \
      -DPython_EXECUTABLE=/usr/local/software/master/python/3.8/bin/python ../OpenMS
```

## References

Strauss, M.T., et al., AlphaPept, a modern and open framework for MS-based proteomics. bioRxiv, 2021: p. 2021.07.23.453379. [https://www.biorxiv.org/content/10.1101/2021.07.23.453379v1](https://www.biorxiv.org/content/10.1101/2021.07.23.453379v1).

[^benchmark]: Benchmark

    Download file from [Dropbox](https://www.dropbox.com/sh/lb0agu7q7yg6w3x/AAAX4ENfgVeAq841qglH9rxAa?dl=0).

    ```bash
    ln -s alphapept-0.4.8 alphapept
    unzip hpc_setup.zip
    ```

    which gives `alphapept_test.py` and `pyopenms_test.py` above along with data files.

[^contrib]: Contributed software

    This was identified after initial attempt.

    ```bash
    wget https://abibuilder.cs.uni-tuebingen.de/archive/contrib/os_support/scientific_linux_7/dependencies_ball.sh
    wget https://abibuilder.cs.uni-tuebingen.de/archive/openms/OpenMSInstaller/release/2.8.0/OpenMS-2.8.0-src.tar.gz
    wget -nd --execute="robots = off" --mirror --convert-links --no-parent --wait=5 https://abibuilder.cs.uni-tuebingen.de/archive/openms/contrib/source_packages/
    ```

    The last `wget` statement is much more efficient to download all the software.

---

## Independent installations

They are generic and not necessarily bound to OpenMS.

### xerces

Web: [https://xerces.apache.org/index.html](https://xerces.apache.org/index.html)

```bash
wget -qO- https://downloads.apache.org/xerces/c/3/sources/xerces-c-3.2.3.tar.gz | \
tar xvfz -
cd xerces-c-3.2.3
./configure --prefix=${Caprion}
make
make install
export INCLUDE=$INCLUDE:{Caprion}/include
export LD_LIBRAYR_PATH=$LD_LIBRARY_PATH:${Caprion}/lib
export PATH=$PATH:${Caprion}/bin
export XercesC_INCLUDE_DIR=${Caprion}/include
export XercesC_LIBRARY=${Caprion}/lib
export XercesC_VERSION=3.2.3
```

### LibSVM

Web: [](https://www.csie.ntu.edu.tw/~cjlin/libsvm/oldfiles/index-1.0.html)

```bash
wget http://www.csie.ntu.edu.tw/~cjlin/cgi-bin/libsvm.cgi?+http://www.csie.ntu.edu.tw/~cjlin/libsvm -O libsvm-3.3.zip
unzip libsvm-3.3.zip
cd libsvm-3.3
make lib
cp libsvm.so.3 ${Caprion}/lib
cd python
python setup.py install --prefix=${Caprion}/py38
```