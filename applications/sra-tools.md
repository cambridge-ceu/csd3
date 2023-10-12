---
sort: 49
---

# sra-tools

Web: <https://github.com/ncbi/sra-tools>

## ncbi-vdb

The installation is preceeded with `module load gcc/6 flex-2.6.4-gcc-5.4.0-2u2fgon`. Although `configure` is provided, `cmake` is used instead.

```bash
cd $CEUADMIN
wget -qO- https://github.com/ncbi/ncbi-vdb/archive/refs/tags/3.0.8.tar.gz | tar xvfz -
mv ncbi-vdb-3.0.8 3.0.8
cd 3.0.8/build
cmake -DCMAKE_PREFIX_PATH=$CEUADMIN/ncbi-vdb/3.0.8 -DCMAKE_INSTALL_PREFIX=$CEUADMIN/ncbi-vdb/3.0.8 ..
make
make install
```

## sra-tools

First, create a symbolic link for `ncbi-vdb/3.0.8` in the parent directory: `ln -s ../ncbi-vdb/3.0.8/ ncbi-3.0.8` since both are within `$CEUADMIN`.

Drop `constexpr` as in `constexpr size_type max_size() const { return SIZE_MAX; }` in line 161 of the following header file:

`/usr/local/Cluster-Apps/ceuadmin/sra-tools/3.0.8/tools/external/driver-tool/util.hpp`.

Now we proceed similarly to `ncbi-vdb` above.

```bash
cd $CEUADMIN
wget -qO- https://github.com/ncbi/sra-tools/archive/refs/tags/3.0.8.tar.gz | tar xvfz -
mv sra-tools-3.0.8 3.0.8
cd 3.0.8/build
cmake -DVDB_LIBDIR=$CEUADMIN/ncbi-vdb/3.0.8/lib64 -DCMAKE_INSTALL_PREFIX=$CEUADMIN/sra-tools/3.0.8 ..
make
make install
```

## modules

This is available from `module load ceuadmin/sra-tools`

## Application

We have `gastric.list` with two records,

```
SRR8244777
SRR8244854
```

Our SLURM script is named `gastric.sb` as follows,

```bash
#!/usr/bin/bash

#SBATCH --job-name gastric
#SBATCH --account PETERS-SL3-CPU
#SBATCH --partition icelake-himem
#SBATCH --array=1-2
#SBATCH --time=10:00:00
#SBATCH --mail-type=NONE
#SBATCH --output=/rds/project/jmmh2/rds-jmmh2-public_databases/CPTAC/TEMP/_gastric_%A_%a.o
#SBATCH --error=/rds/project/jmmh2/rds-jmmh2-public_databases/CPTAC/TEMP/_gastric_%A_%a.e

. /etc/profile.d/modules.sh
module purge
module load rhel8/default-icl
module load ceuadmin/sra-tools/3.0.8

TMPDIR=~/rds/rds-jmmh2-public_databases/CPTAC/TEMP/
destdir=~/rds/rds-jmmh2-public_databases/CPTAC/TEMP/gastric_Korea_2019/SRA_PRJNA505380/

accession=$(awk -v n=${SLURM_ARRAY_TASK_ID} 'NR==n' gastric.list)
application="fasterq-dump"
options="-t ${TMPDIR} -O ${destdir} ${accession}"
cd $TMPDIR
echo -e "Changed directory from $SLURM_SUBMIT_DIR to $TMPDIR.\n"
CMD="$application $options"
eval $CMD
echo -e "JobID: $SLURM_JOB_ID\n======"
echo "Time: `date`"
echo "Running on master node: `hostname`"
echo "Current directory: `pwd`"
if [ "$SLURM_JOB_NODELIST" ]; then
        #! Create a machine file:
        export NODEFILE=`generate_pbs_nodefile $SLURM_JOB_NODELIST`
        cat $NODEFILE | uniq > machine.file.$SLURM_ARRAY_TASK_ID
        echo -e "\nNodes allocated:\n================"
        cat machine.file.$SLURM_ARRAY_TASK_ID | sed -e 's/\..*$//g'
fi
echo -e "\nExecuting command:\n==================\n$CMD\n"
cd -
```

and submitted as `sbatch gastric.sb`.

By default, the download is split into three parts which can be combined as follows,

```bash
fasterq-dump <accession> --concatenate-reads --include-technical
```

See also <https://github.com/ncbi/sra-tools/wiki/08.-prefetch-and-fasterq-dump>.

## Additional notes

Call to `fasterq-dump` in the SLURM script above could produce error as follows,

```
Loading rhel8/default-icl
  Loading requirement: dot rhel8/slurm singularity/current rhel8/global
    cuda/11.4 vgl/2.5.1/64 intel-oneapi-compilers/2022.1.0/gcc/b6zld2mz
    intel-oneapi-mpi/2021.6.0/intel/guxuvcpm
Loading ceuadmin/sra-tools/3.0.8
  Loading requirement: gcc/6 flex-2.6.4-gcc-5.4.0-2u2fgon
2023-10-10T15:52:30 sratools.3.0.8 err: libs/vfs/names4-response.c:2293:Response4StatusInit: error unexpected while resolving query within virtual file system module - No accession to process ( 500 )
Failed to call external services.
```

Use of `prefetch` nevertheless gives similar error.

It appears to be an issue with SLURM, for `vdb-dump <accession>` confirms availability of the accessions and `prefetch <accession>` works from an interactive Linux session.

Consequently, we resort to `GNU parallel` as follows,

```bash
#!/usr/bin/bash

module load perl-5.20.0-gcc-5.4.0-4npvg5p
module load ceuadmin/sra-tools

export TMPDIR=~/rds/rds-jmmh2-public_databases/CPTAC/TEMP
export cwd=${PWD}
cd ${TMPDIR}/prefetch
cat ${cwd}/gastric.list | \
parallel -C' ' -j5 '
  export accession={}
  (
    vdb-dump ${accession} --info
    prefetch --force ALL --transport http --max-size u --progress ${accession}
  ) > ${accession}.log
'
cd -
```

Now the issue with `Perl` also goes away under `cclake-himem`, and `fasterq-dump` can be used to extract the `.sra` file for each accession after remote access is disabled from `vdb-config -i`.
