---
sort: 35
---

# OpenMS

Web: <https://openms.de/>, <https://openms.readthedocs.io/en/latest/>

## AlphaPept and pyOpenMS

Web: AlphaPept: [https://github.com/MannLabs/alphapept](https://github.com/MannLabs/alphapept) ([latest installer](https://github.com/MannLabs/alphapept/releases/latest)), pyOpenMS: <https://pyopenms.readthedocs.io/en/latest/index.html>

The prerequisites involve CSD3 location, [GNU C](https://gcc.gnu.org/), [cmake](https://cmake.org/), [TeX Live](https://www.tug.org/texlive/) and [Miniconda](https://docs.conda.io/en/latest/miniconda.html).

```bash
export root=/rds/project/rds-4o5vpvAowP0/software
source $root/py3.11/bin/activate
pip install alphapept
pip install pyopenms
pip install autowrap
pip install pytest
```

which installs alphapept 0.5.3 and pyopenms 3.3.0.

Script for testing is called `alphapept_test.py` [^benchmark] which takes the following arguments,

| Name                                                                               | Description                                                                          |
| ---------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| `alphapept_settings.yaml`                                                          | A configuratino file containing relevant information, e.g., paths and `n_processes`. |
| `szwk021704i19101xms1.raw`, `szwk021704i19101xms3.raw`, `szwk021704i19101xms5.raw` | Raw spectra                                                                          |
| `2022-07-05-reviewed-contam-UP000005640.fasta`                                     | Database of protein sequences:                                                       |

A more recent example is available from Google CoLab ([AlphaPept.ipynb](files/AlphaPept.ipynb)) as in Strauss, et al. (2024).

## 3.4.0

We keep the GitHub clone intact.

```bash
module load gcc/11.2.0/gcc/rjvgspag
module load texlive
git clone https://github.com/OpenMS/OpenMS
cd OpenMS/
git submodule update --init contrib
git clone https://github.com/OpenMS/THIRDPARTY/
git submodule update --init THIRDPARTY
cd $root
# build contrib
mkdir contrib-build
cd contrib-build
cmake -DBUILD_TYPE=ALL -DNUMBER_OF_JOBS=4 -Wno-dev ../OpenMS/contrib
# build OpenMS
cd $root
mkdir OpenMS-build
cd OpenMS-build
module load ceuadmin/qt/6.8.2
cmake -DCMAKE_BUILD_TYPE=Release -DOPENMS_CONTRIB_LIBS=$root/contrib-build \
      -DNUMBER_OF_JOBS=4 \
      -DBOOST_USE_STATIC=ON -DQt6_DIR=$CEUADMIN/6.8.2 -DPYOPENMS=On \
      -DSEARCH_ENGINES_DIRECTORY=$root/OpenMS/THIRDPARTY/Linux/64bit \
      -DCMAKE_INSTALL_PREFIX=$CEUADMIN/OpenMS/3.4.0 ../OpenMS
make targets
```

where the `contrib-build/archives` directory contains the following files (\* = to obtain from -DBUILD_TYPE=).

```
boost_1_78_0.tar.gz
bzip2-1.0.5.tar.gz
CoinMP-1.8.3-vs22.tar.gz
eigen-3.4.0.tar.gz
glpk-4.46.tar.gz*
hdf5-1_14_3.tar.gz
kissfft-130.tar.gz*
libsvm-3.12.tar.gz
openmp-12.0.1.src.tar.xz*
Xerces-C_3_2_0.tar.gz
zlib-1.2.11.tar.gz
```

and the module `ceuadmin/qt/6.8.2` is used instead for its compactness, especially `CMAKE_MODULE_PATH` is set.
The command `git clone https://github.com/OpenMS/THIRDPARTY/` downloads third-party files into the THIRDPARTY directory.

The option -DPYOPENMS=On in fact builds `pyopenms` as well, which can be loaded as follows,

```python
import sys
import os

root = os.getenv('root')
sys.path.append(os.path.join(root, 'pyOpenMS'))
import pyopenms
```

More importantly, we can have the following screenshot:

```
$ OpenMSInfo

Full documentation: http://www.openms.de/doxygen/release/3.4.0/html/TOPP_OpenMSInfo.html
To cite OpenMS:
 + Pfeuffer, J., Bielow, C., Wein, S. et al.. OpenMS 3 enables reproducible analysis of large-scale mass spectrometry data. Nat Methods (2024
   ). doi:10.1038/s41592-024-02197-7.

<< OpenMS Version >>
Version      : 3.4.0
Build time   : Mar 19 2025, 09:52:16
Git sha1     : 20ead3d
Git branch   : heads/release/3.3.0

<< Installation information >>
Data path    : /rds/project/rds-4o5vpvAowP0/software/OpenMS/share/OpenMS
Temp path    : /rds/user/jhz22/hpc-work/work
Userdata path: /home/jhz22/

<< Build information >>
Source path  : /rds/project/rds-4o5vpvAowP0/software/OpenMS/src/openms
Binary path  : /rds/project/rds-4o5vpvAowP0/software/OpenMS-build/src/openms
Binary arch  : 64 bit
Build type   : Release
LP-Solver    : COIN-OR
OpenMP       : enabled (maxThreads = 1)
SIMD extensions : SSE, SSE2, SSE3
Extra CXX flags : <none>

<< OS Information >>
Name: Linux
Version: 8.10
Architecture: 64 bit

OpenMSInfo took 0.13 s (wall), 0.00 s (CPU), 0.00 s (system), 0.00 s (user); Peak Memory Usage: 28 MB.
```

## Singularity

```bash
singularity run ghcr.io/openms/openms-library-sif
singularity run ghcr.io/openms/openms-executables-sif
```

## OpenMS/3.0.0-pre-develop-2022-09-28

### CSD3 location

The `ceuadmin/OpenMS/3.0.0-pre-develop-2022-09-28` module is at the follow location,

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
git clone https://github.com/OpenMS/THIRDPARTY/
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

### Sigularity

```bash
singularity pull docker://ghcr.io/openms/openms-library:3.0.0
singularity pull docker://ghcr.io/openms/openms-executables::3.0.0
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

Strauss MT, et al., AlphaPept: a modern and open framework for MS-based proteomics. _Nat Commun_ 15, 2168 (2024). <https://doi.org/10.1038/s41467-024-46485-4>.

Rost HL, et al., OpenMS: a flexible open-source software platform for mass spectrometry data analysis. _Nat Methods_ 13, 9: 741-748 (2016). [doi:10.1038/nmeth.3959](https://www.nature.com/articles/nmeth.3959).

Pfeuffer J, et al. OpenMS 3 enables reproducible analysis of large-scale mass spectrometry data. _Nat Methods_ 21, 365–367 (2024). <https://doi.org/10.1038/s41592-024-02197-7>

## A summary of commands

Table: Summary from Pfeuffer et al. (2024)

| Graphical Tools                       | TOPPView                        | A viewer for mass spectrometry data.                                                                                                           |
| :------------------------------------ | :------------------------------ | :--------------------------------------------------------------------------------------------------------------------------------------------- |
|                                       | TOPPAS                          | An assistant for GUI-driven TOPP workflow design.                                                                                              |
|                                       | INIFileEditor                   | An editor for OpenMS configuration files.                                                                                                      |
|                                       | SwathWizard                     | A user-friendly step-by-step wizard for SWATH data analysis.                                                                                   |
| File Converter                        | FileConverter                   | Converts between different MS file formats.                                                                                                    |
|                                       | GNPSExport                      | Export MS/MS data in .MGF format for GNPS.                                                                                                     |
|                                       | IDFileConverter                 | Converts between different identification file formats.                                                                                        |
|                                       | MSstatsConverter                | Convert to MSstats input file format.                                                                                                          |
|                                       | MzTabExporter                   | Exports various XML formats to an mzTab file.                                                                                                  |
|                                       | TargetedFileConverter           | Converts targeted files (such as tsv or TraML files).                                                                                          |
|                                       | TextExporter                    | Exports various XML formats to a text file.                                                                                                    |
|                                       | TriqlerConverter                | Convert to Triqler input file format.                                                                                                          |
| File Filtering / Extraction / Merging | DatabaseFilter                  | Filter protein databases.                                                                                                                      |
|                                       | DecoyDatabase                   | Creates decoy peptide databases from normal ones.                                                                                              |
|                                       | DTAExtractor                    | Extracts spectra of an MS run file to several files in DTA format.                                                                             |
|                                       | FileFilter                      | Extracts or manipulates portions of data from peak, feature or consensus feature files.                                                        |
|                                       | FileInfo                        | Shows basic information about the file, such as data ranges and file type.                                                                     |
|                                       | FileMerger                      | Merges several MS files into one file.                                                                                                         |
|                                       | IDFilter                        | Filters results from protein or peptide identification engines based on different criteria.                                                    |
|                                       | IDMerger                        | Merges several protein/peptide identification files into one file.                                                                             |
|                                       | IDRipper                        | Splits protein/peptide identifications according their file-origin.                                                                            |
|                                       | IDSplitter                      | Splits protein/peptide identifications off of annotated data files.                                                                            |
|                                       | MapStatistics                   | Extract extended statistics on the features of a map for quality control.                                                                      |
|                                       | MzMLSplitter                    | Splits an mzML file into multiple parts.                                                                                                       |
| Spectrum processing: Centroiding      | PeakPickerHiRes                 | Peak detection in high-resolution profile mass spectra.                                                                                        |
|                                       | PeakPickerIterative             | Peak detection in high-resolution profile TOF data (based on PeakPickerHiRes with some postprocessing)                                         |
|                                       | PeakPickerWavelet               | Peak detection in low-resolution (ion trap) profile mass spectra.                                                                              |
| Spectrum processing:                  | BaselineFilter                  | Removes the baseline from profile spectra using a top-hat filter.                                                                              |
| peak smoothing & normalization        | NoiseFilterGaussian             | Removes noise from profile spectra using a Gaussian smoothing.                                                                                 |
|                                       | NoiseFilterSGolay               | Removes noise from profile spectra using Savitzky-Golay smoothing.                                                                             |
|                                       | MapNormalizer                   | Normalizes peak intensities in an MS run.                                                                                                      |
|                                       | SpectraFilterBernNorm           | Scales and filters spectra according to the Bern norm.                                                                                         |
|                                       | SpectraFilterNLargest           | Keeps only the n largest peaks per spectrum.                                                                                                   |
|                                       | SpectraFilterNormalizer         | Scale intensities per spectrum to either sum to 1 or have a maximum of 1.                                                                      |
|                                       | SpectraFilterParentPeakMower    | Removes high peaks that could stem from unfragmented precursor ions.                                                                           |
|                                       | SpectraFilterScaler             | Assigns new intensity per spectrum according to intensity rank.                                                                                |
|                                       | SpectraFilterSqrtMower          | Scales the intensity of peaks to their sqrt.                                                                                                   |
|                                       | SpectraFilterThresholdMower     | Removes all peaks below an intensity threshold.                                                                                                |
|                                       | SpectraFilterWindowMower        | Retains the highest peaks in a sliding or jumping window.                                                                                      |
| Spectrum processing: Misc             | MaRaClusterAdapter              | Run the spectral clustering implemented in MaRaCluster.                                                                                        |
|                                       | Resampler                       | Transforms an LC-MS map into an equally-spaced (in RT and m/z) map.                                                                            |
|                                       | SpectraMerger                   | Merges spectra from an LC-MS map, either by precursor or by RT blocks.                                                                         |
| Mass Correction and Calibration       | InternalCalibration             | Applies an internal mass calibration (using PSMs or fixed masses).                                                                             |
|                                       | ExternalCalibration             | Applies an external mass calibration.                                                                                                          |
|                                       | HighResPrecursorMassCorrector   | Correct the precursor entries of tandem MS scans for high resolution data.                                                                     |
|                                       | IDRTCalibration                 | Can be used to calibrate RTs of peptide hits linearly to standards.                                                                            |
|                                       | PrecursorMassCorrector          | Correct the precursor m/z entries of tandem MS scans (low-res only).                                                                           |
|                                       | TOFCalibration                  | Applies time of flight mass calibration.                                                                                                       |
| Quantitation                          | ConsensusMapNormalizer          | Normalizes maps of one consensusXML file (after linking).                                                                                      |
|                                       | Decharger                       | Decharges and merges different feature charge variants of the same chemical entity.                                                            |
|                                       | EICExtractor                    | Quantifies signals at given positions in (raw or picked) LC-MS maps.                                                                           |
|                                       | ERPairFinder                    | Evaluates pair ratios on enhanced resolution (ER = zoom) scans.                                                                                |
|                                       | FeatureFinderCentroided         | Detects two-dimensional features in centroided LC-MS data.                                                                                     |
|                                       | FeatureFinderIdentification     | Detects two-dimensional features in MS1 data based on peptide identifications.                                                                 |
|                                       | FeatureFinderIsotopeWavelet     | Detects two-dimensional features in uncentroided (=raw) LC-MS (low-res)                                                                        |
|                                       | FeatureFinderMetabo             | Detects two-dimensional features in centroided LC-MS data of metabolites.                                                                      |
|                                       | FeatureFinderMetaboIdent        | Detects features in MS1 data corresponding to small molecule identifications.                                                                  |
|                                       | FeatureFinderMRM                | Quantifies features LC-MS/MS MRM data.                                                                                                         |
|                                       | FeatureFinderMultiplex          | Identifies peptide multiplets (pairs, triplets etc., e.g. for SILAC or Dimethyl labeling) and determines their relative abundance.             |
|                                       | IsobaricAnalyzer                | Extracts and normalizes TMT and iTRAQ information from an MS experiment.                                                                       |
|                                       | MassTraceExtractor              | Annotates mass traces in centroided LC-MS maps.                                                                                                |
|                                       | MetaboliteAdductDecharger       | Decharges and merges different feature charge variants of the same small molecule.                                                             |
|                                       | MetaProSIP                      | Detect labeled peptides from protein-SIP experiments.                                                                                          |
|                                       | MultiplexResolver               | Resolves conflicts between identifications and quantifications in multiplex data.                                                              |
|                                       | ProteinQuantifier               | Computes protein abundances from annotated feature/consensus maps.                                                                             |
|                                       | ProteinResolver                 | A peptide-centric algorithm for protein inference.                                                                                             |
|                                       | ProteomicsLFQ                   | Perform label-free quantification in a single tool.                                                                                            |
|                                       | SeedListGenerator               | Generates seed lists for feature detection.                                                                                                    |
| Identification of                     | CometAdapter                    | Identifies MS/MS spectra using Comet (external).                                                                                               |
| Proteins/Peptides                     | LuciphorAdapter                 | Scores potential phosphorylation sites in order to localize the most probable sites.                                                           |
| (SearchEngines)                       | MascotAdapter                   | Identifies MS/MS spectra using Mascot (external).                                                                                              |
|                                       | MascotAdapterOnline             | Identifies MS/MS spectra using Mascot (external).                                                                                              |
|                                       | MSFraggerAdapter                | Peptide Identification with MSFragger.                                                                                                         |
|                                       | MSGFPlusAdapter                 | Identifies MS/MS spectra using MSGFPlus (external).                                                                                            |
|                                       | NovorAdapter                    | De novo sequencing from tandem mass spectrometry data.                                                                                         |
|                                       | SageAdapter                     | Identifies MS/MS spectra using Sage (external).                                                                                                |
|                                       | SimpleSearchEngine              | A simple database search engine for annotating MS/MS spectra.                                                                                  |
|                                       | SpecLibSearcher                 | Identifies peptide MS/MS spectra by spectral matching with a searchable spectral library.                                                      |
|                                       | SpectraSTSearchAdapter          | An interface to the 'SEARCH' mode of the SpectraST program (external, beta).                                                                   |
|                                       | XTandemAdapter                  | Identifies MS/MS spectra using XTandem (external).                                                                                             |
| Identification Processing             | ConsensusID                     | Computes a consensus identification from peptide identifications of several identification engines.                                            |
|                                       | Digestor                        | Digests a protein database in-silico.                                                                                                          |
|                                       | DigestorMotif                   | Digests a protein database in-silico (optionally allowing only peptides with a specific motif) and produces statistical data for all peptides. |
|                                       | Epifany                         | Bayesian protein inference based on PSM probabilities.                                                                                         |
|                                       | FalseDiscoveryRate              | Estimates the false discovery rate on peptide and protein level using decoy searches.                                                          |
|                                       | IDConflictResolver              | Resolves ambiguous annotations of features with peptide identifications.                                                                       |
|                                       | IDExtractor                     | Extracts n peptides randomly or best n from idXML files.                                                                                       |
|                                       | IDMapper                        | Assigns protein/peptide identifications to feature or consensus features.                                                                      |
|                                       | IDMassAccuracy                  | Calculates a distribution of the mass error from given mass spectra and IDs.                                                                   |
|                                       | IDPosteriorErrorProbability     | Estimates posterior error probabilities using a mixture model.                                                                                 |
|                                       | IDScoreSwitcher                 | Switches between different scores of peptide or protein hits in identification data.                                                           |
|                                       | PeptideIndexer                  | Refreshes the protein references for all peptide hits.                                                                                         |
|                                       | PercolatorAdapter               | Applies the percolator algorithm to protein/peptide identifications.                                                                           |
|                                       | PhosphoScoring                  | Scores potential phosphorylation sites in order to localize the most probable sites.                                                           |
|                                       | ProteinInference                | Infer proteins from a list of (high-confidence) peptides.                                                                                      |
|                                       | PSMFeatureExtractor             | Creates search engine specific features for PercolatorAdapter input.                                                                           |
|                                       | SequenceCoverageCalculator      | Prints information about idXML files.                                                                                                          |
|                                       | SpecLibCreator                  | Creates an MSP-formatted spectral library.                                                                                                     |
|                                       | StaticModification              | Allows to attach a set of fixed modifications to an idXML file (MS/MS search results), e.g. to add 15N (N15) labeling post-hoc.                |
| Map Alignment                         | MapAlignerIdentification        | Corrects RT distortions between maps based on common peptide identifications using one map as reference.                                       |
|                                       | MapAlignerPoseClustering        | Corrects RT distortions between maps using a pose clustering approach (not using pep-ids and alinear model)                                    |
|                                       | MapAlignerSpectrum              | Corrects RT distortions between maps by spectrum alignment.                                                                                    |
|                                       | MapAlignerTreeGuided            | Corrects RT distortions between maps based on common peptide identifications guided by a similarity tree.                                      |
|                                       | MapRTTransformer                | Applies RT transformations to maps.                                                                                                            |
| Feature linking                       | FeatureLinkerLabeled            | Groups corresponding isotope-labeled features in a feature map.                                                                                |
|                                       | FeatureLinkerUnlabeled          | Groups corresponding features from multiple maps.                                                                                              |
|                                       | FeatureLinkerUnlabeledQT        | Groups corresponding features from multiple maps using a QT clustering approach.                                                               |
|                                       | FeatureLinkerUnlabeledKD        | Groups corresponding features from multiple maps using a KD tree.                                                                              |
| Targeted Experiments                  | AssayGeneratorMetabo            | Generates an assay library using DDA data (Metabolomics).                                                                                      |
| and OpenSWATH                         | ClusterMassTracesByPrecursor    | Identifies precursor mass traces and tries to correlate them with fragment ion mass traces in SWATH maps.                                      |
|                                       | MRMMapper                       | MRMMapper maps measured chromatograms (mzML) and the transitions used (TraML).                                                                 |
|                                       | MRMPairFinder                   | Evaluates labeled pair ratios on MRM features.                                                                                                 |
|                                       | MRMTransitionGroupPicker        | Picks peaks in MRM chromatograms.                                                                                                              |
|                                       | OpenSwathAnalyzer               | Picks peaks and finds features in an SRM experiment.                                                                                           |
|                                       | OpenSwathAssayGenerator         | Generates filtered and optimized assays using TraML files.                                                                                     |
|                                       | OpenSwathChromatogramExtractor  | Extract chromatograms (XIC) from a MS2 map file.                                                                                               |
|                                       | OpenSwathConfidenceScoring      | Computes confidence scores for OpenSwath results.                                                                                              |
|                                       | OpenSwathDecoyGenerator         | Generates decoys according to different models for a specific TraML.                                                                           |
|                                       | OpenSwathDIAPreScoring          | SWATH (data-idependent acquisition) pre-scoring                                                                                                |
|                                       | OpenSwathFeatureXMLToTSV        | Converts a featureXML to a tsv.                                                                                                                |
|                                       | OpenSwathFileSplitter           | Splitting a single SWATH / DIA file into a set of files, each containing one SWATH window.                                                     |
|                                       | OpenSwathMzMLFileCacher         | Caching of large mzML files.                                                                                                                   |
|                                       | OpenSwathRewriteToFeatureXML    | Rewrites results from mProphet back into featureXML.                                                                                           |
|                                       | OpenSwathRTNormalizer           | Align an SRM / SWATH run to a normalized retention time space.                                                                                 |
|                                       | OpenSwathWorkflow               | Complete workflow to run OpenSWATH.                                                                                                            |
| Cross-linking                         | OpenPepXL                       | Search for peptide pairs linked with a labeled cross-linker                                                                                    |
|                                       | OpenPepXLLF                     | Search for cross-linked peptide paris in tandem MS spectra.                                                                                    |
|                                       | RNPxlSearch                     | Annotates RNA-peptide cross-links in MS/MS spectra.                                                                                            |
|                                       | RNPxlXICFilter                  | Removes MS2 spectra from treatment based on the fold change between control and treatment for RNA-to-peptide cross-linking experiments.        |
|                                       | XFDR                            | Calculates false discovery rate estimates on cross-link identifications.                                                                       |
| Top down                              | FLASHDeconv                     | Computes a feature deconvolution from Top down MS data.                                                                                        |
| Quality Control                       | QualityControl                  | A one-in-all QC tool to generate an augmented mzTab.                                                                                           |
|                                       | DatabaseSuitability             | Calculates the suitability of a database for peptide identification search using a de novo approach.                                           |
|                                       | QCCalculator                    | Calculates basic quality parameters from MS experiments and compiles data for subsequent QC into a qcML file.                                  |
|                                       | QCEmbedder                      | Embeds tables or plots generated externally as attachments to existing quality parameters in qcML files.                                       |
|                                       | QCExporter                      | Extracts several quality parameter from several runs/sets from a qcML file into a tabular (text) format - counterpart to QCImporter.           |
|                                       | QCExtractor                     | Extracts a table attachment of a given quality parameter from a qcML file as tabular (text) format.                                            |
|                                       | QCImporter                      | Imports several quality parameters from a tabular (text) format into a qcML file - counterpart to QCExporter.                                  |
|                                       | QCMerger                        | Merges two qcML files together.                                                                                                                |
|                                       | QCShrinker                      | Removes extra verbose table attachments from a qcML file that are not needed anymore, e.g. for a final report.                                 |
| Metabolite Identification             | AccurateMassSearch              | Finds potential HMDB IDs within the given mass error window.                                                                                   |
|                                       | MetaboliteSpectralMatcher       | Identifies small molecules from tandem MS spectra.                                                                                             |
|                                       | SiriusAdapter                   | De novo metabolite identification.                                                                                                             |
| RNA                                   | NucleicAcidSearchEngine         | Search MzML files for oligonucleotides and their modifications.                                                                                |
|                                       | RNADigestor                     | Digests an RNA sequence database in-silico.                                                                                                    |
|                                       | RNAMassCalculator               | Calculates masses and mass-to-charge ratios of RNA sequences.                                                                                  |
| Misc / Helpers                        | ClusterMassTraces               | Cluster mass traces occurring in the same map together.                                                                                        |
|                                       | DeMeanderize                    | Orders the spectra of MALDI spotting plates correctly.                                                                                         |
|                                       | ExecutePipeline                 | Executes workflows created by TOPPAS.                                                                                                          |
|                                       | GenericWrapper                  | Allows the generic wrapping of external tools.                                                                                                 |
|                                       | ImageCreator                    | Creates images from MS1 data (with MS2 data points indicated as dots).                                                                         |
|                                       | INIUpdater                      | Updates INI and TOPPAS files from previous versions of OpenMS as parameters and storage method might have change                               |
|                                       | MassCalculator                  | Calculates masses and mass-to-charge ratios of peptide sequences.                                                                              |
|                                       | MetaProSIP                      | Performs proteinSIP on peptide features for elemental flux analysis.                                                                           |
|                                       | OpenMSInfo                      | Print system information.                                                                                                                      |
|                                       | TICCalculator                   | Calculates the TIC of a raw mass spectrometric file.                                                                                           |
| [for developers]                      | CVInspector                     | Visualization and validation of PSI mapping and CV files.                                                                                      |
|                                       | FuzzyDiff                       | Compares two files, tolerating numeric differences.                                                                                            |
|                                       | JSONExporter                    | Exports .oms (SQLite) files in JSON format                                                                                                     |
|                                       | OpenMSDatabasesInfo             | prints the content of OpenMS' enzyme and modification databases to a TSV file.                                                                 |
|                                       | SemanticValidator               | SemanticValidator for analysisXML and mzML files.                                                                                              |
|                                       | XMLValidator                    | Validates XML files against an XSD schema.                                                                                                     |

## Other URLs

- OpenMS, [SourceForge](https://sourceforge.net/projects/open-ms/); [GITTER](https://gitter.im/OpenMS/OpenMS), [wikiwand](https://www.wikiwand.com/en/OpenMS), [OpenSWATH](https://openswath.org/en/latest/).
- tlmgr, [tlmgr.pdf](https://tug.ctan.org/info/tlmgrbasics/doc/tlmgr.pdf), [Installing_Extra_Packages](https://en.wikibooks.org/wiki/LaTeX/Installing_Extra_Packages), [pkginstall](https://www.tug.org/texlive/pkginstall.html), [Rstudio query](https://community.rstudio.com/t/latex-language-package-installation-not-working/51596/3).

---

[^python]:
    The website <https://cmake.org/cmake/help/latest/module/FindPython.html> explains several options which appear unnecessary for cmake 3.19.

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
