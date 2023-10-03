#!/usr/bin/bash

mkdir MyHLA2HPED_HIBAG MyIMGT2Seq MyNomenCleaner MyOmnibusTest MyLogisticReg MyManhattan MyHeatmap
source ~/COVID-19/py37/bin/activate
python HATK.py \
    --hla2hped \
    --platform HIBAG \
    --out MyHLA2HPED_HIBAG/MyHIBAG \
    --rhped \
      example/HLA2HPED/HIBAG/HIBAG_TestResult.HLA-A.out \
      example/HLA2HPED/HIBAG/HIBAG_TestResult.HLA-B.out \
      example/HLA2HPED/HIBAG/HIBAG_TestResult.HLA-C.out \
      example/HLA2HPED/HIBAG/HIBAG_TestResult.HLA-DPA1.out \
      example/HLA2HPED/HIBAG/HIBAG_TestResult.HLA-DPB1.out \
      example/HLA2HPED/HIBAG/HIBAG_TestResult.HLA-DQA1.out \
      example/HLA2HPED/HIBAG/HIBAG_TestResult.HLA-DQB1.out \
      example/HLA2HPED/HIBAG/HIBAG_TestResult.HLA-DRB1.out
python3 HATK.py \
    --imgt2seq \
    --hg 18 \
    --imgt 3320 \
    --out MyIMGT2Seq/ExamplePrefix.hg18.imgt3320 \
    --imgt-dir example/IMGTHLA3320 \
    --multiprocess 2
python3 HATK.py \
    --nomencleaner \
    --hat example/RESULT_EXAMPLE/HLA_ALLELE_TABLE.imgt3320.hat \
    --hped example/wtccc_filtered_58C_RA.hatk.300+300.hped \
    --out MyNomenCleaner/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18.2field \
    --2field \
    --imgt 3320
python3 HATK.py \
    --nomencleaner \
    --hat example/RESULT_EXAMPLE/HLA_ALLELE_TABLE.imgt3320.hat \
    --hped example/wtccc_filtered_58C_RA.hatk.300+300.hped \
    --out MyNomenCleaner/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18 \
    --imgt 3320
python3 HATK.py \
    --omnibus \
    --fam example/wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18.fam \
    --phased example/OmnibusTest/wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18.bgl.phased \
    --out MyOmnibusTest/wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18 \
    --pheno example/wtccc_filtered_58C_RA.hatk.300+300.phe \
    --pheno-name RA
python3 HATK.py \
    --omnibus \
    --fam example/wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18.fam \
    --aa example/OmnibusTest/wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18.aa \
    --out MyOmnibusTest/wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18 \
    --pheno example/wtccc_filtered_58C_RA.hatk.300+300.phe \
    --pheno-name RA
python HATK.py \
    --logistic \
    --input example/RESULT_EXAMPLE/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18 \
    --pheno-name RA \
    --pheno example/wtccc_filtered_58C_RA.hatk.300+300.phe \
    --out MyLogisticReg/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18
python HATK.py \
    --manhattan \
    --ar example/RESULT_EXAMPLE/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18.assoc.logistic \
    --imgt 3320 \
    --hg 18 \
    --out MyManhattan/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18
python HATK.py \
    --manhattan \
    --ar example/OmnibusTest/wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18.RA.NA.omnibus \
    --imgt 3320 \
    --hg 18 \
    --out MyManhattan/wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18.RA.NA.omnibus \
    --HLA A DRB1 DQA1 DQB1
python HATK.py \
    --heatmap \
    --ar example/RESULT_EXAMPLE/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18.assoc.logistic \
    --HLA A \
    --maptable example/RESULT_EXAMPLE/HLA_MAPTABLE_A.hg18.imgt3320.txt \
    --out MyHeatmap/RESULT_EXAMPLE_wtccc_filtered_58C_RA.hatk.300+300.chr6.hg18
