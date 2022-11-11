---
sort: 49
---

# SurvivalGWAS_SV

Web: [https://www.liverpool.ac.uk/population-health/research/groups/statistical-genetics/softwareandresources/](https://www.liverpool.ac.uk/population-health/research/groups/statistical-genetics/softwareandresources/)

## Mono

Web: [https://www.mono-project.com/](https://www.mono-project.com/).

Suppose we have `hello.cs` containing the following lines

```cs
using System;

public class HelloWorld
{
    public static void Main(string[] args)
    {
        Console.WriteLine ("Hallo, world!");
    }
}
```

```bash
module load mono-5.10.0.78-gcc-5.4.0-c6cq4hh
csc hello.cs
mono hello.exe
```

## Installation

```bash
wget https://www.liverpool.ac.uk/media/livacuk/instituteoftranslationalmedicine/biostats/SurvivalGWAS_SV,v1.3.2.zip
cd SurvivalGWAS_SV\ v1.3.2
# batch example
wget https://www.liverpool.ac.uk/media/livacuk/instituteoftranslationalmedicine/biostats/batchexample.sh
```

## Testing

```bash
mono survivalgwas-sv.exe -gf=Sample\ data/exchr10.out.controls.gen -sf=Sample\ data/samplefile.txt -threads=1 -m=cox -t=eventtime -c=Status -cov=cov1,cov2 -lstart=1 -lstop=20 -o=test
```

## Reference

Syed, H., Jorgensen, A.L. & Morris, A.P. SurvivalGWAS_SV: software for the analysis of genome-wide association studies of imputed genotypes with “time-to-event” outcomes. BMC Bioinformatics 18, 265 (2017). https://doi.org/10.1186/s12859-017-1683-z
