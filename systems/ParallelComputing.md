---
sort: 10
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

Additional note is worthwhile about Bash function, as demonstrated by the following script,

```bash
function turboman()
{
  R --slave --vanilla --args \
    input_data_path=${phenotype}.txt.gz \
    output_data_rootname=${phenotype} \
    custom_peak_annotation_file_path=${phenotype}.annotate \
    reference_file_path=turboman_hg19_reference_data.rda \
    pvalue_sign=1e-2 \
    plot_title="${phenotype}" < turboman.r
}

export -f turboman

parallel -C' ' -j4 --env _ '
  echo {}
  export phenotype={}
  turboman
' ::: chronotype sleep_duration insomnia snoring
```

where function `turboman` is exported and called by `parallel`. The `--env _` options copies exported all variables except those in `~/.parallel/ignored_vars`, while `env_parallel` would copy all export/non-exported variables.

Note that the two options are preceded with `parallel --record-env` and `env_parallel --install`, respectively.

To kill processes with a pattern, we use `pkill -f "pattern"`.

## SLURM

Official website: [https://slurm.schedmd.com/](https://slurm.schedmd.com/).

CSD3 User guide, <https://docs.hpc.cam.ac.uk/hpc/user-guide/batch.html>

Location at csd3: `/usr/local/Cluster-Docs/SLURM/`.

The directory `/usr/local/software/slurm/current/bin/` contains all the executables..

### Updates

<font color="red"><b>30/1/2025 Update</b></font> SLURM is now version 23.11.10.

### Account details

```bash
mybalance
```

Note that after software updates on 26/4/2022, this command only works on non-login nodes such as icelake.

### Partition

The skylakes have been decommissioned, <https://docs.hpc.cam.ac.uk/hpc/user-guide/cclake.html> and <https://docs.hpc.cam.ac.uk/hpc/user-guide/icelake.html>. For Ampere GPU, see <https://docs.hpc.cam.ac.uk/hpc/user-guide/a100.html>.

```bash
scontrol show partition
sinfo -p sapphire -o "%P %D %C %m %d %f %G %t %T %N"
```

which shows information on all partitions and a specific one, respectively.

**Partition-Level Information**

| Specifier | Description                                                                                                                                                |   |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- | - |
| `%P`      | **Partition name**: The name of the partition.                                                                                                             |   |
| `%D`      | **Number of nodes**: The total number of nodes in the partition.                                                                                           |   |
| `%C`      | **CPUs by state**: Displays the number of CPUs in the format `allocated/idle/other/total`. This provides a breakdown of CPU usage across different states. |   |
| `%m`      | **Memory per node**: The size of memory per node in megabytes.                                                                                             |   |
| `%d`      | **Temporary disk space**: The size of temporary disk space per node in megabytes.                                                                          |   |
| `%f`      | **Features**: Features associated with the nodes. These are typically hardware or software capabilities assigned to the nodes.                             |   |
| `%G`      | **Generic resources (gres)**: Generic resources associated with the nodes. This includes specialized hardware like GPUs.                                   |   |
| `%t`      | **State (compact)**: The state of nodes in a compact form. Possible states include `allocated`, `idle`, `mixed`, `down`, `drained`, `draining`.            |   |
| `%T`      | **State (extended)**: The state of nodes in an extended form. Provides a more detailed description of the node's state.                                    |   |
| `%N`      | **Node names**: List of node names.                                                                                                                        |   |

**Additional Useful Specifiers**

| Specifier | Description                                                                                                                                              |   |
| --------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | - |
| `%a`      | **State/availability of a partition**: Indicates whether the partition is available (`yes`) or not (`no`).                                               |   |
| `%A`      | **Number of nodes by state**: Displays the number of nodes in the format `allocated/idle`.                                                               |   |
| `%B`      | **Max CPUs per node**: Shows the maximum number of CPUs per node available to jobs in the partition.                                                     |   |
| `%c`      | **CPUs per node**: Displays the number of CPUs per node.                                                                                                 |   |
| `%e`      | **Free memory**: Displays the total memory, in MB, currently free on the node as reported by the OS.                                                     |   |
| `%E`      | **Node unavailability reason**: Provides the reason a node is unavailable (e.g., down, drained, or draining states).                                     |   |
| `%g`      | **Groups**: Lists groups which may use the nodes.                                                                                                        |   |
| `%h`      | **Oversubscription setting**: Indicates if jobs may oversubscribe compute resources (i.e., CPUs), with values like `yes`, `no`, `exclusive`, or `force`. |   |
| `%I`      | **Partition job priority weighting factor**: Displays the partition job priority weighting factor.                                                       |   |
| `%l`      | **Maximum job time**: Shows the maximum time for any job in the format `days-hours:minutes:seconds`.                                                     |   |
| `%L`      | **Default job time**: Displays the default time for any job in the format `days-hours:minutes:seconds`.                                                  |   |
| `%M`      | **Preemption mode**: Shows the preemption mode.                                                                                                          |   |
| `%n`      | **Node hostnames**: Lists the node hostnames.                                                                                                            |   |
| `%o`      | **Node communication addresses**: Lists the node communication addresses.                                                                                |   |
| `%O`      | **CPU load**: Displays the CPU load of a node as reported by the OS.                                                                                     |   |
| `%p`      | **Partition scheduling tier priority**: Shows the partition scheduling tier priority.                                                                    |   |
| `%r`      | **Root user job initiation**: Indicates if only the root user may initiate jobs, with values `yes` or `no`.                                              |   |
| `%s`      | **Maximum job size**: Shows the maximum job size in nodes.                                                                                               |   |
| `%S`      | **Allowed allocating nodes**: Lists the allowed allocating nodes.                                                                                        |   |
| `%u`      | **User who set unavailability**: Prints the username of who set the reason a node is unavailable.                                                        |   |
| `%U`      | **User and UID who set unavailability**: Prints the username and UID of who set the reason a node is unavailable.                                        |   |
| `%v`      | **Slurmd version**: Prints the version of the running `slurmd` daemon.                                                                                   |   |
| `%w`      | **Scheduling weight**: Displays the scheduling weight of the nodes.                                                                                      |   |
| `%X`      | **Sockets per node**: Shows the number of sockets per node.                                                                                              |   |
| `%Y`      | **Cores per socket**: Displays the number of cores per socket.                                                                                           |   |
| `%Z`      | **Threads per core**: Shows the number of threads per core.                                                                                              |   |
| `%z`      | **Processor information**: Provides extended processor information in the format `sockets:cores:threads` per node.                                       |   |

A SLURM partition checking script by Campbell Wolford, [slurm_partition_checking.sh](files/slurm_partition_checking.sh).


### An interactive job

CSD3 user guide for an interactive session, <https://docs.hpc.cam.ac.uk/hpc/user-guide/interactive.html>

```bash
sintr -A MYPROJECT -p skylake -N2 -n2 -t 1:0:0 --qos=INTR
```

and also

```bash
srun -N1 -n1 -c4 -p cclake-himem -t 12:0:0 --pty bash -i
srun -p icelake-himem --qos=INTR -t 1:0:0 --pty bash -i
```

with -A to specify account name, e.g.,  -A PETERS-SL3-CPU.

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

For cclake, we have

```bash
. /etc/profile.d/modules.sh
module purge
module load rhel7/default-ccl
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

### xargs

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

The following example illustrates job canceling with status "PD" but leaving those running untouched,

```
$ squeue -u jhz22
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
    41800594_[1-4] cclake-hi _3-CADM1    jhz22 PD       0:00      1 (None)
   41800593_[1-11] cclake-hi _3-CADH6    jhz22 PD       0:00      1 (None)
   41800592_[1-44] cclake-hi _3-CADH5    jhz22 PD       0:00      1 (None)
   41800591_[1-13] cclake-hi _3-CADH1    jhz22 PD       0:00      1 (None)
    41800590_[1-2] cclake-hi _3-CAD19    jhz22 PD       0:00      1 (None)
   41800589_[1-19] cclake-hi _3-CA2D1    jhz22 PD       0:00      1 (None)
   41800588_[1-43] cclake-hi _3-C4BPA    jhz22 PD       0:00      1 (None)
  41800587_[1-113] cclake-hi   _3-C1S    jhz22 PD       0:00      1 (None)
   41800586_[1-13] cclake-hi  _3-C1RL    jhz22 PD       0:00      1 (None)
   41800585_[1-90] cclake-hi   _3-C1R    jhz22 PD       0:00      1 (None)
    41800584_[1-3] cclake-hi _3-C1QR1    jhz22 PD       0:00      1 (None)
   41800583_[1-23] cclake-hi  _3-C1QC    jhz22 PD       0:00      1 (None)
   41800582_[1-41] cclake-hi  _3-C1QB    jhz22 PD       0:00      1 (None)
    41800581_[1-5] cclake-hi   _3-BTK    jhz22 PD       0:00      1 (None)
   41800580_[1-11] cclake-hi  _3-BST1    jhz22 PD       0:00      1 (None)
      41800344_[1] cclake-hi  _3-AMYP    jhz22 PD       0:00      1 (Priority)
       41800236_51 cclake-hi   _3-ALS    jhz22  R       0:31      1 cpu-p-198
       41800236_53 cclake-hi   _3-ALS    jhz22  R       0:31      1 cpu-p-597
       41800337_12 cclake-hi  _3-AMBP    jhz22  R       0:31      1 cpu-p-490
       41800337_14 cclake-hi  _3-AMBP    jhz22  R       0:31      1 cpu-p-490
        41800338_3 cclake-hi   _3-AMD    jhz22  R       0:31      1 cpu-p-251
        41800162_1 cclake-hi _3-AGRG6    jhz22  R       1:14      1 cpu-p-251
      41800059_160 cclake-hi  _3-AACT    jhz22  R       1:34      1 cpu-p-417
        41798125_1 cclake-hi _3-AGRG6    jhz22  R       7:19      1 cpu-p-418
      41797610_160 cclake-hi  _3-AACT    jhz22  R       7:52      1 cpu-p-597
      41747018_214 cclake-hi _3-ITIH2    jhz22  R    4:07:36      1 cpu-p-245
      41705768_214 cclake-hi _3-ITIH2    jhz22  R   11:18:49      1 cpu-p-245

```

or `squeue -u $USER --state=suspend -o "%.18i %.9P %.8j %.8u %.2t %.10M %.6D %R"`.

We also use `xargs`,

```bash
squeue -u jhz22 | grep PD | awk '{print $1}' | xargs -l -I {} scancel {}
```

To cancel jobs on a specific partition, use `-p <partition-name>`. Moreover, we have `cat urls.txt | xargs -n 1 -P 8 wget` where `-n 1` ensures that each Wget command processes one URL at a time, and `-P 8` allows up to 8 parallel processes.

### Enumeration

This example shows loop by enumeration as follows,

```bash
wget https://huggingface.co/unsloth/Llama-4-Maverick-17B-128E-Instruct-GGUF/resolve/main/Q8_0/Llama-4-Maverick-17B-128E-Instruct-Q8_0-0000{1..9}-of-00009.gguf
module load ceuadmin/llama.cpp/4991
llama-gguf-split --merge Llama-4-Maverick-17B-128E-Instruct-Q8_0-00001-of-00009.gguf Llama-4-Maverick-17B-128E-Instruct.gguf
```

which actually downloads all 9 files sequentially. If it is preferable to parallelise within each file, one can resort to `aria2c -x 16 -s 16 [URL]` where `-x 8` sets the maximum number of connections per server, and `-s 8` splits the download into 8 segments, respectively. On the other hand, `curl` allows for particular chunks in a file to be downloaded.
