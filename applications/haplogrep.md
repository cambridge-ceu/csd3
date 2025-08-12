---
sort: 29
---

# haplogrep

Web: <https://haplogrep.i-med.ac.at/> ([haplogrep2](https://haplogrep.i-med.ac.at/haplogrep2/index.html)) & <https://haplogrep.readthedocs.io/en/latest/>

## 3.2.2

### Installation

```bash
# haplogrep3
wget https://github.com/genepi/haplogrep3/releases/download/v3.2.2/haplogrep3-3.2.2-linux.zip
unzip haplogrep3-3.2.2-linux.zip
haplogrep3 server --config haplogrep3.yaml
haplogrep3 trees
haplogrep3 classify --in data/examples/example-microarray.vcf --out microarray.txt --tree=phylotree-rsrs@17.0
haplogrep3 classify --in data/examples/example-wgs.vcf --out wgs.txt --tree=phylotree-rsrs@17.0
wget https://raw.githubusercontent.com/genepi/phylotree-rsrs-17/refs/heads/main/src/rsrs.fasta
haplogrep3 classify --in rsrs.fasta --out rsrs.txt --tree phylotree-rsrs@17.0
```

See also <https://genepi.github.io/haplogrep-trees/>.

### Hail MatrixTable

```bash
# hail dense/sparse MatrixTable -- too large to be tested!
module load openjdk/11.0.12_7/gcc/czpuqhmv
python <<END
gsutil -m cp -r \
gs://gcp-public-data--gnomad/release/3.1.2/mt/genomes/gnomad.genomes.v3.1.2.hgdp_1kg_subset_sparse.mt .
mt = hl.read_matrix_table("gnomad.genomes.v3.1.2.hgdp_1kg_subset_sparse.mt")
mt = mt.filter_rows(mt.locus.contig == 'chrM')
hl.export_vcf(mt, "chrM.vcf.bgz")
mt_small = mt.sample_rows(0.1)  # Keep 10% of variants
mt_small = mt_small.sample_cols(0.01)  # Keep 1% of samples
hl.export_vcf(mt_small, "chrM_subset.vcf.bgz")
END
# gnomAD 3.1 has chrM.vcf.bgz
haplogrep3 classify --in chrM.vcf.bgz --out haplogrep_output.txt --tree phylotree-rsrs@17.0
```

## 2.4.0

### Installation

```bash
# cmd only
curl -sL haplogrep.now.sh | bash
# GitHub
wget -qO- https://github.com/seppinho/haplogrep-cmd/archive/refs/tags/v2.4.0.tar.gz | tar xfz -
cd haplogrep-cmd-2.4.0/
bash install/github-downloader.sh
# test
wget https://github.com/seppinho/haplogrep-cmd/raw/master/test-data/vcf/HG00097.vcf.gz
./haplogrep classify --in HG00097.vcf.gz --format vcf --out haplogroups.txt
```

### Example

The following offers glimpse of findings from sloan, et al. (2015), <https://royalsocietypublishing.org/doi/suppl/10.1098/rspb.2015.1704>. For instance, we have $0.019 \ge r^2 \le 0.024$.

```bash
python3 < hgdp.py
module load ceuadmin/haplogrep/2.4.0
haplogrep classify --in data/examples/example-wgs.vcf --out hg.txt --format=vcf
# suppress double quote, asterisk and plus ("*+)
sed -i 's/"//g' hg.txt
awk '{ gsub(/[^a-zA-Z0-9]/,"", $2); print $1 "\t" $2 }' hg.txt > hg_simple_clean.txt
sloan15.pl sloan15_input.txt hg_simple_clean.txt > sloan15.tsv
Rscript -e '
 ld <- read.delim("sloan15.tsv",check=FALSE)
 summary(ld)
'
```

where [hgdp.py](files/hgdp.py) is used to reformat the data to a required format by [sloan15.pl](files/sloan15.pl).
