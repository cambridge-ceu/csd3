---
sort: 1
---

# ABCtoolbox

Web page: [https://bitbucket.org/wegmannlab/abctoolbox/wiki/Home](https://bitbucket.org/wegmannlab/abctoolbox/wiki/Home)

Now there is a `Makefile` so a simple `make` will furnish the exeutable file.

However, the initial attempt to use `openmpi` remains valid.

```bash
git clone --depth 1 https://bitbucket.org/wegmannlab/abctoolbox.git
# g++ -O3 -o ABCtoolbox *.cpp
module load openmpi/3.1.4-gcc-7.2.0
g++ -O3 -o ABCtoolbox *.cpp -DUSE_OMP -fopenmp
```

Note that the installation guide has misspecified the repository.
