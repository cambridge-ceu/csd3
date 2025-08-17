---
sort: 15
---

# cli

Web: <https://cli.github.com/>

This is done as follows,

```bash
wget -qO- https://github.com/cli/cli/archive/refs/tags/v2.76.2.tar.gz | tar xfvz -
cd cli-2.76.2/
module load ceuadmin/go/1.21.6
make
make install prefix=$CEUADMIN/cli/2.76.2
```

The `ceuadmin/go/1.21.6` module allows for the required version (go: go.mod requires go >= 1.24.0 (running go 1.23.6; GOTOOLCHAIN=local)) to be downloaded. Now we use this to fork,

```bash
gh auth login
gh auth status
gh repo fork OrangeAVA/Ultimate-Neural-Network-Programming-with-Python --org cambridge-ceu
cd Ultimate-Neural-Network-Programming-with-Python
git checkout -b jhz
# correct typos, modify file paths, rename model/att_net.py, ...
git push --set-upstream origin jhz
wget -qO- https://thor.robots.ox.ac.uk/~vgg/data/pets/annotations.tar.gz | tar xfz -
wget -qO- https://thor.robots.ox.ac.uk/~vgg/data/pets/images.tar.gz | tar xfz -
```

We fork a repository. create a branch, and send a pull request. The forked repository is available, <https://github.com/cambridge-ceu/Ultimate-Neural-Network-Programming-with-Python>, which has been merged into the author's master branch.
