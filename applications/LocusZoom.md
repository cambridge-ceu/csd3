---
sort: 26
---

# LocusZoom

Web: <https://genome.sph.umich.edu/wiki/LocusZoom_Standalone>

The installation is standard and can be found from `~/rds/public_databases/software/locuszoom_1.4`. Noted below are reference panel using INTERVAL data (hg19).

## snp_pos.txt

The following script creates a SNP-position file (~90M).

```bash
#!/usr/bin/bash

export interval=~/rds/post_qc_data/interval/
export impute=${interval}/imputed/uk10k_1000g_b37
export snpstats=${interval}/reference_files/genetic/reference_files_genotyped_imputed/
export X=/rds/project/jmmh2/rds-jmmh2-projects/covid/ace2/interval_genetic_data/interval_imputed_data
export TMPDIR=${HPC_WORK}/work

function snp_pos()
{
# autosomes sorted by alleles appropriate for meta-analysis
  (
    for chr in {1..22}
    do
      cut -f1,3-6,19 ${snpstats}/impute_${chr}_interval.snpstats | \
      awk 'NR>1{
       chr=$2+0
       pos=$3
       a1=$4
       a2=$5
       if(a1>a2) snpid="chr"chr":"pos"_"a2"_"a1;
       else snpid="chr"chr":"pos"_"a1"_"a2
       if($1==".") rsid=snpid; else rsid=$1
       print rsid,chr,pos
      }'
    done
    awk '{print $5,23,$2}' ${X}/INTERVAL_X_imp_ann_filt_v2_stats.txt
  ) | sort -k2,2n -k3,3n > interval.snp_pos.csv
  sed -i 's/ /,/g' interval.snp_pos.csv
}

snp_pos
``````

## snp_pos table

We first examine the schema of built-in SNP-position counterpart from `locuszoom_hg19.db`.

```
$ sqlite3 locuszoom_hg19.db
.tables
.schema snp_pos
.quit
```

A customised database is thus derived via `cp -p locuszoom_hg19.db locuszoom_interval_hg19.db` (faster than `.save locuszoom_interval_hg19.db` inside `sqlite3` above).

Now the INTERVAL SNP-position file above is taken.

```sqlite3
sqlite3 locuszoom_interval_hg19.db
DROP TABLE IF EXISTS snp_pos;
CREATE TABLE snp_pos ( snp TEXT, chr INTEGER, pos INTEGER );
.mode csv
.import /home/jhz22/interval.snp_pos.csv snp_pos
CREATE INDEX ind_snp_pos_chrpos ON snp_pos (chr,pos);
CREATE INDEX ind_snp_pos_snp ON snp_pos (snp);
.quit
```

We could check availability of chromosome X data with `select * from snp_pos where chr==23;`.

## genotypes

Our genotype files are built as follows,

```bash
#!/usr/bin/bash

#SBATCH --job-name=_interval_
#SBATCH --mem=50000
#SBATCH --time=12:00:00

#SBATCH --account PETERS-SL3-CPU
#SBATCH --partition cclake-himem

#SBATCH --export ALL
#SBATCH --array=1-22
#SBATCH --output=_%A_%a.o
#SBATCH --error=_%A_%a.e

. /etc/profile.d/modules.sh
module purge
module load rhel7/default-ccl

export interval=~/rds/post_qc_data/interval/
export impute=${interval}/imputed/uk10k_1000g_b37
export chr=$SLURM_ARRAY_TASK_ID
export src=${impute}/impute_${chr}_interval.bgen
export dst=~/rds/public_databases/software/locuszoom_1.4/data/interval/genotypes/EUR

# as in 1000Gwenomes 2014 version with ChrX added here, 1000G/genotypes/2014-10-14/EUR
if [ ! -d ${dst} ]; then mkdir -p ${dst}; fi

function autosomes()
{
plink2 --bgen ${impute}/impute_{}_interval.bgen ref-unknown \
       --sample ${impute}/interval.samples \
       --export bgen-1.2 bits=8 --dosage-erase-threshold 0.001 \
       --set-missing-var-ids chr@:#_\$r_\$a --new-id-max-allele-len 680 \
       --make-bed \
       --out ${dst}/chr${chr}
}

function X()
{
  plink2 --vcf ${X}/INTERVAL_X_imp_ann_filt_v2.vcf.gz \
         --export bgen-1.2 bits=8 \
         --dosage-erase-threshold 0.001 \
         --set-missing-var-ids @:#_\$r_\$a \
         --new-id-max-allele-len 680 \
         --out ${dst}/chrX
}

# autosomes
X
```

A specific handling is made with respect to chromosome X.

## m2zfast.conf

This is the LocusZoom configuration file, whose entries are extended accordingly.

```
# Required programs.
METAL2ZOOM_PATH = "bin/locuszoom.R";
NEWFUGUE_PATH = "new_fugue";
PLINK_PATH = "plink";
RSCRIPT_PATH = "Rscript";
TABIX_PATH = "tabix";

# SQLite database settings.
SQLITE_DB = {
  'hg18' : "data/database/locuszoom_hg18.db",
  'hg19' : "data/database/locuszoom_hg19.db",
  'interval37' : "data/database/locuszoom_interval_hg19.db",
  'hg38' : "data/database/locuszoom_hg38.db",
};

# GWAS catalog files
GWAS_CATS = {
  'hg18' : {
    'whole-cat_significant-only' : {
      'file' : "data/gwas_catalog/gwas_catalog_hg18.txt",
      'desc' : "The NHGRI GWAS catalog, filtered to SNPs with p-value < 5E-08"
    }
  },
  'hg19' : {
    'whole-cat_significant-only' : {
      'file' : "data/gwas_catalog/gwas_catalog_hg19.txt",
      'desc' : "The EBI GWAS catalog, filtered to SNPs with p-value < 5E-08"
    }
  },
  'interval37' : {
    'whole-cat_significant-only' : {
      'file' : "data/gwas_catalog/gwas_catalog_hg19.txt",
      'desc' : "The EBI GWAS catalog, filtered to SNPs with p-value < 5E-08"
    }
  },
  'hg38' : {
    'whole-cat_significant-only' : {
      'file' : "data/gwas_catalog/gwas_catalog_hg38.txt",
      'desc' : "The EBI GWAS catalog, filtered to SNPs with p-value < 5E-08"
    }
  }
}

# Location of genotypes to use for LD calculations.
LD_DB = {
  # 1000G phase 3
  '1000G_Nov2014' : {
    'hg19' : {
      'EUR' : {
        'bim_dir' : "data/1000G/genotypes/2014-10-14/EUR/",
      },
      'ASN' : {
        'bim_dir' : "data/1000G/genotypes/2014-10-14/ASN/",
      },
      'AFR' : {
        'bim_dir' : "data/1000G/genotypes/2014-10-14/AFR/",
      },
      'AMR' : {
        'bim_dir' : "data/1000G/genotypes/2014-10-14/AMR/",
      }
    },
    'hg38' : {
      'EUR' : {
        'bim_dir' : "data/1000G/genotypes/2017-04-10/EUR/",
      },
      'AFR' : {
        'bim_dir' : "data/1000G/genotypes/2017-04-10/AFR/",
      },
      'AMR' : {
        'bim_dir' : "data/1000G/genotypes/2017-04-10/AMR/",
      },
      'EAS' : {
        'bim_dir' : "data/1000G/genotypes/2017-04-10/EAS/",
      },
      'SAS' : {
        'bim_dir' : "data/1000G/genotypes/2017-04-10/SAS/",
      }
    }
  },
  '1000G_March2012' : {
    'hg19' : {
      'EUR' : {
        'bim_dir' : "data/1000G/genotypes/2012-03/EUR/",
      },
      'ASN' : {
        'bim_dir' : "data/1000G/genotypes/2012-03/ASN/",
      },
      'AFR' : {
        'bim_dir' : "data/1000G/genotypes/2012-03/AFR/",
      },
      'AMR' : {
        'bim_dir' : "data/1000G/genotypes/2012-03/AMR/",
      }
    }
  },
  '1000G_June2010' : {
    'hg18' : {
      'CEU' : {
        'ped_dir' : "data/1000G/genotypes/2010-06/CEU/pedFiles/",
        'map_dir' : "data/1000G/genotypes/2010-06/CEU/mapFiles/"
      },
      'JPT+CHB' : {
        'ped_dir' : "data/1000G/genotypes/2010-06/JPT+CHB/pedFiles/",
        'map_dir' : "data/1000G/genotypes/2010-06/JPT+CHB/mapFiles/"
      },
      'YRI' : {
        'ped_dir' : "data/1000G/genotypes/2010-06/YRI/pedFiles/",
        'map_dir' : "data/1000G/genotypes/2010-06/YRI/mapFiles/"
      }
    }
  },
  'hapmap' : {
    'hg18' : {
      'CEU' : {
        'ped_dir' : "data/hapmap/genotypes/2008-10_phaseII/CEU/pedFiles/",
        'map_dir' : "data/hapmap/genotypes/2008-10_phaseII/CEU/mapFiles/"
      },
      'JPT+CHB' : {
        'ped_dir' : "data/hapmap/genotypes/2008-10_phaseII/JPT+CHB/pedFiles/",
        'map_dir' : "data/hapmap/genotypes/2008-10_phaseII/JPT+CHB/mapFiles/"
      },
      'YRI' : {
        'ped_dir' : "data/hapmap/genotypes/2008-10_phaseII/YRI/pedFiles/",
        'map_dir' : "data/hapmap/genotypes/2008-10_phaseII/YRI/mapFiles/"
      }
    }
  },
  'interval' : {
    'interval37' : {
      'EUR' : {
        'bim_dir' : "data/interval/genotypes/EUR/",
      }
    }
  }
}
```

## Example
