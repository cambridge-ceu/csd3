---
sort: 3
---

# glmnet

Web: [https://glmnet.stanford.edu/](https://glmnet.stanford.edu/).

### 0.99.52

There are various error messages across R and gcc, but this amendment gets it compiled smoothly.

```bash
module lost gcc/8
tar xvfz DescTools_0.99.52.tar.gz
sed -i '/LinkingTo/i\SystemRequirements: C++17' DescTools/DESCRIPTION
R CMD INSTALL DescTools
```

where file `DESCRIPTION` is modified adding `SystemRequirements: C++17` before the LinkingTo directive.
