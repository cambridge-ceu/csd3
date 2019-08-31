# 31-8-2019 JHZ

# at CSD3

cd /rds/project/jmmh2/rds-jmmh2-projects/olink_proteomics/scallop/
mkdir -p /scratch/curated_genetic_data/phenotypes/interval/high_dimensional_data jp549

# from Cardio

for d in \
/DO-NOT-MODIFY-SCRATCH/curated_genetic_data/phenotypes/interval/high_dimensional_data/Olink_proteomics_cvd2/qc \
/DO-NOT-MODIFY-SCRATCH/curated_genetic_data/phenotypes/interval/high_dimensional_data/Olink_proteomics_cvd3/qc \
/DO-NOT-MODIFY-SCRATCH/curated_genetic_data/phenotypes/interval/high_dimensional_data/Olink_proteomics_neurology/qc \
/DO-NOT-MODIFY-SCRATCH/curated_genetic_data/phenotypes/interval/high_dimensional_data/Olink_proteomics_cvd2/gwasqc
do
  ls $d
done

/DO-NOT-MODIFY-SCRATCH/bp406/apps/software/data_manipulation/rsync-3.1.3/rsync -av --partial \
/DO-NOT-MODIFY-SCRATCH/curated_genetic_data/phenotypes/interval/high_dimensional_data/ \
login-cpu.hpc.cam.ac.uk:/rds/project/jmmh2/rds-jmmh2-projects/olink_proteomics/scallop/\
/scratch/curated_genetic_data/phenotypes/interval/high_dimensional_data

for d in \
/DO-NOT-MODIFY-SCRATCH/jp549/analyses/interval_subset_olink/ \
/DO-NOT-MODIFY-SCRATCH/jp549/mhplots-olink-imp \
/DO-NOT-MODIFY-SCRATCH/jp549/pah-pqtl-input-data
do
  /DO-NOT-MODIFY-SCRATCH/bp406/apps/software/data_manipulation/rsync-3.1.3/rsync -av --partial \
  $d login-cpu.hpc.cam.ac.uk:/rds/project/jmmh2/rds-jmmh2-projects/olink_proteomics/scallop/jp549
done
 
# from CSD3 -- too long to create symbolic links!

cd /rds/project/jmmh2/rds-jmmh2-projects/olink_proteomics/scallop/
for d in `ls /rds/project/jmmh2/rds-jmmh2-projects/olink_proteomics/scallop/scratch/curated_genetic_data/phenotypes/interval/high_dimensional_data`
do
  ln -s $d
done
