---
sort: 22
---

# KentUtils

This is part of the Kent utilities in module `kentutils-302.1-gcc-5.4.0-kbiujaa` nevertheless without the appropriate chain file.

To download the latest utilitiess, try `rsync -aP rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/linux.x86_64/ ./`.

The most notable is liftOver from UCSC here, [https://genome.ucsc.edu/cgi-bin/hgLiftOver](https://genome.ucsc.edu/cgi-bin/hgLiftOver).

Suppose we have `r6-b38-A2.bed`,

```
#CHROM	start	end	SNP
chr1	841851	841852	1:841852:C:T
chr1	856472	856473	1:856473:G:A
chr1	858951	858952	1:858952:G:A
chr1	859841	859842	1:859842:C:G
chr1	863420	863421	1:863421:G:A
chr1	863578	863579	1:863579:G:A
chr1	864118	864119	1:864119:T:C
chr1	866155	866156	1:866156:T:G
chr1	866280	866281	1:866281:C:T
```

To convert back to b37, our syntax is as follows,

```bash
liftOver r6-b38-A2.bed hg38ToHg19.over.chain.gz r6-b37-A2.bed r6-b37-A2.unlifted.bed
```

with `r6-b37-A2.bed` containing these lines,

```
chr1	777231	777232	1:841852:C:T
chr1	791852	791853	1:856473:G:A
chr1	794331	794332	1:858952:G:A
chr1	795221	795222	1:859842:C:G
chr1	798800	798801	1:863421:G:A
chr1	798958	798959	1:863579:G:A
chr1	799498	799499	1:864119:T:C
chr1	801535	801536	1:866156:T:G
chr1	801660	801661	1:866281:C:T
```
