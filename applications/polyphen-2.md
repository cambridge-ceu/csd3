---
sort: 55
---

# polyphen-2

Official page: [http://genetics.bwh.harvard.edu/pph2/dokuwiki/start](http://genetics.bwh.harvard.edu/pph2/dokuwiki/start).

The setup can be furnished as follows,

```bash
cd $HPC_WORK
wget -qO- http://genetics.bwh.harvard.edu/pph2/dokuwiki/_media/polyphen-2.2.2r405c.tar.gz | tar xfz
wget -qO- ftp://genetics.bwh.harvard.edu/pph2/bundled/polyphen-2.2.2-databases-2011_12.tar.bz2 | tar xjf
wget -qO- ftp://genetics.bwh.harvard.edu/pph2/bundled/polyphen-2.2.2-alignments-mlc-2011_12.tar.bz2 | tar xjf
wget -qO- ftp://genetics.bwh.harvard.edu/pph2/bundled/polyphen-2.2.2-alignments-multiz-2009_10.tar.bz2 | tar xjf
ls  | sed 's/\*//g' | parallel -C' ' 'ln -sf $HPC_WORK/polyphen-2.2.2/bin/{} $HPC_WORK/bin/{}'
cd polyphen-2.2.2
# set up BLAST/nrdb/PDB as decribed below
cd src
make
make install
cd -
configure
cd bin
rsync -aP rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/linux.x86_64/ ./
cd -
```

The MLC/MULTIZ databases need to be extracted to $HOME and symbolically linked if the number of files exceed 1 million
(limit on RDS). Then these are necessary,

```bash
cd $HPC_WORK/polyphen-2.2.2
ln -s $HOME/polyphen-2.2.2/precompiled
cd ucsc/hg19/multiz
ln -s $HOME/polyphen-2.2.2/ucsc/hg19/multiz/precomputed
```

The availability of MLC/MULTIZ databases make the annotation considerably faster.

The command `configure` creates files at config/ which can be changed maunaually. There is also
[user's guide](http://genetics.bwh.harvard.edu/pph2/dokuwiki/_media/hg0720.pdf). The line `rsync` obtains
programs such as `twoBitToFa` as required by the example below.

BLAST and nrdb can be set up as follows,

```bash
rmdir blast
ln -sf /usr/local/Cluster-Apps/blast/2.4.0 blast
cd nrdb
wget -qO- ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/uniref/uniref100/uniref100.fasta.gz | \
gunzip -c > uniref100.fasta
../update/format_defline.pl uniref100.fasta >uniref100-formatted.fasta
../blast/bin/makeblastdb -in uniref100-formatted.fasta -dbtype prot -out uniref100 -parse_seqids
rm -f uniref100.fasta uniref100-formatted.fasta
```

and for PDB

```bash
rsync -rltv --delete-after --port=33444 \
      rsync.wwpdb.org::ftp/data/structures/divided/pdb/ wwpdb/divided/pdb/
rsync -rltv --delete-after --port=33444 \
      rsync.wwpdb.org::ftp/data/structures/all/pdb/ wwpdb/all/pdb/
```

Our test is then,

```bash
cd $HPC_WORK/polyphen-2.2.2
run_pph.pl sets/test.input 1>test.pph.output 2>test.pph.log
run_weka.pl test.pph.output >test.humdiv.output
run_weka.pl -l models/HumVar.UniRef100.NBd.f11.model test.pph.output >test.humvar.output

sdiff test.humdiv.output sets/test.humdiv.output
sdiff test.humvar.output sets/test.humvar.output
```

Now we turn to an genomic SNPs query examples with snps.pph.list containing the following line,

> chr1:154426970 A/C

to be called by `mapsnps.pl` and others.

```bash
mapsnps.pl -g hg19 -m -U -y snps.pph.input snps.pph.list 1>snps.pph.features 2>snps.log
run_pph.pl snps.pph.input 1>snps.pph.output 2>snps.pph.log
run_weka.pl snps.pph.output >snps.humdiv.output
run_weka.pl -l models/HumVar.UniRef100.NBd.f11.model snps.pph.output >snps.humvar.output
```

for [.pph.input](files/snps.pph.input), [.pph.features](files/snps.pph.features), [.pph.output](files/snps.pph.output), [.humvar.output](files/snps.humvar.output) and [.humdiv.output](files/snps.humdiv.output).
