---
sort: 8
---

# Parallel Computing

## GNU Parallel

Web: <https://www.gnu.org/software/parallel/>


### An example

To convert a large number of PDF files (INTERVAL.\*.manhattn.pdf) to PNG with smaller file sizes. To start, we build a file list, and pipe into `parallel`.

```bash
ls *pdf | \
sed 's/INTERVAL.//g;s/.manhattan.pdf//g' | \
parallel -j8 -C' ' '
  echo {}
  pdftopng -r 300 INTERVAL.{}.manhattan.pdf
  mv {}-000001.png INTERVAL.{}.png
'
```

## SLURM

Official website: [https://slurm.schedmd.com/](https://slurm.schedmd.com/).

Location at csd3: `/usr/local/Cluster-Docs/SLURM/`.

The directory `/usr/local/software/slurm/current/bin/` contains all the executables..

### Account details

```bash
mybalance
```

Note that after software updates on 26/4/2022, this command only works on non-login nodes such as icelake.

### Partition

```bash
scontrol show partition
```

The skylakes have been decommissioned, [https://docs.hpc.cam.ac.uk/hpc/user-guide/cclake.html](https://docs.hpc.cam.ac.uk/hpc/user-guide/cclake.html) and [https://docs.hpc.cam.ac.uk/hpc/user-guide/icelake.html](https://docs.hpc.cam.ac.uk/hpc/user-guide/icelake.html). For Ampere GPU, see [https://docs.hpc.cam.ac.uk/hpc/user-guide/a100.html](https://docs.hpc.cam.ac.uk/hpc/user-guide/a100.html).

### An interactive job

```bash
sintr -A MYPROJECT -p skylake -N2 -n2 -t 1:0:0 --qos=INTR
```

and also

```bash
srun -N1 -n1 -c4 -p cclake-himem -t 12:0:0 --pty bash -i
```

### Batch job

A batch job is invoked by `sbatch`.

Sample scripts are in `/usr/local/Cluster-Docs/SLURM`, e.g., [template for Skylake](files/slurm_submit.peta4-skylake).

### Starting a job at a specific time

This is achieved with the `-b` or `--begin` option, e.g.,

```bash
sbatch --begin=now+3hour A1BG.sb
```

### Holding and releasing jobs

Suppose a job with id 59230836 is running, they can be achieved with,

```bash
scontrol hold 59230836
control release 59230836
```

respectively.

### Monitoring jobs

This is done with `squeue` command.

The load of a specific partition can be checked with `squeue -p <partition name>`.

For `$USER`, check with `squeue -u $USER`, `qstat -u $USER` and `sacct`.

### Using modules

The following is part of a real project.

```bash
. /etc/profile.d/modules.sh
module purge
module load rhel7/default-peta4

module load gcc/6
module load aria2-1.33.1-gcc-5.4.0-r36jubs
```

For icelake, we have

```bash
. /etc/profile.d/modules.sh
module purge
module load rhel8/default-icl
```

### Temporary directory

Although it is less apparent with a single run, SLURM jobs tend to use large temporary space which can easily be beyond the system default.

The following statement sets a temporary directory, i.e.,

```bash
export TMPDIR=/rds/user/$USER/hpc-work/
```

### Trouble shooting

With error message

```
squeue: error: _parse_next_key: Parsing error at unrecognized key:
InteractiveStepOptions
squeue: error: Parse error in file
/usr/local/software/slurm/slurm-20.11.4/etc/slurm.conf line 22:
"InteractiveStepOptions="--pty --preserve-env --mpi=none $SHELL""
squeue: fatal: Unable to process configuration file
```

then either log out and login again, or

```bash
unset SLURM_CONF
```

### An example

The example in GNU Parallel is turned to SLURM implementation using job arrays (<https://slurm.schedmd.com/job_array.html>).

```bash
#!/usr/bin/bash

#SBATCH --ntasks=1
#SBATCH --job-name=pdftopng
#SBATCH --time=6:00:00
#SBATCH --cpus-per-task=8
#SBATCH --partition=skylake
#SBATCH --array=1-50%10
#SBATCH --output=pdftopng_%A_%a.out
#SBATCH --error=pdftopng_%A_%a.err
#SBATCH --export ALL

export p=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]' INTERVAL.list)
export TMPDIR=/rds/user/$USER/hpc-work/

echo ${p}
pdftopng -r 300 INTERVAL.${p}.manhattan.pdf ${p}
mv ${p}-000001.png INTERVAL.${p}.png
```

To embed SLURM call in a bash script, one can use `sbatch --wait <SLURM scripts>`. SLURM scripts can also be inside the Bash counterpart.

## Other approaches

The following script moves all files a day earlier to directory old/,

```bash
find . -mtime +1 | xargs -l -I {} mv {} old
```

while the code below downloads the SCALLOP-cvd1 sumstats for proteins listed in `cvd1.txt`.

```bash
export url=https://zenodo.org/record/2615265/files/
if [ ! -d ~/rds/results/public/proteomics/scallop-cvd1 ]; then mkdir ~/rds/results/public/proteomics/scallop-cvd1; fi
cat cvd1.txt | xargs -I {} bash -c "wget ${url}/{}.txt.gz -O ~/rds/results/public/proteomics/scallop-cvd1/{}.txt.gz"
#  ln -s ~/rds/results/public/proteomics/scallop-cvd1
```
