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
#!/bin/bash

#SBATCH --job-name gastric
#SBATCH --account PETERS-SL3-CPU
#SBATCH --partition icelake-himem
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --array=1-2
#SBATCH --time=03:00:00
#SBATCH --mail-type=NONE
#SBATCH --output=/rds/project/jmmh2/rds-jmmh2-public_databases/CPTAC/TEMP/_gastric_%A_%a.o
#SBATCH --error=/rds/project/jmmh2/rds-jmmh2-public_databases/CPTAC/TEMP/_gastric_%A_%a.e

. /etc/profile.d/modules.sh
module purge
module load rhel8/default-icl
module load ceuadmin/sra-tools/3.0.8

JOBID=$SLURM_JOB_ID
TMPDIR=~/rds/rds-jmmh2-public_databases/CPTAC/TEMP/
destdir=~/rds/rds-jmmh2-public_databases/CPTAC/TEMP #gastric_Korea_2019/SRA_PRJNA505380/

file=$(awk -v record=${SLURM_ARRAY_TASK_ID} 'NR==record' gastric.list)
application="fasterq-dump"
options="-t ${TMPDIR} ${file} -O ${destdir}"
workdir="$SLURM_SUBMIT_DIR"
cd $workdir
echo -e "Changed directory to `pwd`.\n"
CMD="$application $options"
eval $CMD
cd -
echo -e "JobID: $JOBID\n======"
echo "Time: `date`"
echo "Running on master node: `hostname`"
echo "Current directory: `pwd`"
if [ "$SLURM_JOB_NODELIST" ]; then
        #! Create a machine file:
        export NODEFILE=`generate_pbs_nodefile`
        cat $NODEFILE | uniq > machine.file.$JOBID
        echo -e "\nNodes allocated:\n================"
        echo `cat machine.file.$JOBID | sed -e 's/\..*$//g'`
fi
echo -e "\nExecuting command:\n==================\n$CMD\n"
```

and submitted as `sbatch gastric.sb`.
