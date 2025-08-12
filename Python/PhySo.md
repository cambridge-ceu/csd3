---
sort: 8
---

# PhySO

Web: <https://github.com/WassimTenachi/PhySO>.

## CSD3 module

It is recommended that the following commands are necessary,

```bash
module load ceuadmin/PhySO
. /usr/local/Cluster-Apps/miniconda3/4.5.1/etc/profile.d/conda.sh
conda activate ${PhySO}
```

Line containing `conda.sh` could also be in ~/.bashrc, and `conda deactivate` will unload the module.

However, it appears simpler with

```bash
module load ceuadmin/PhySO
source activate $PhySO
```

with `source deactivate`. In both cases, `PhySO` is already defined by the `ceuadmin/PhySO` module.

## Installation

The download is as usual.

```bash
git clone https://github.com/WassimTenachi/PhySO
cd PhySO
```

It takes more than usual resources, which is necessary to get around with SLURM.

```bash
cat << 'EOL' > ~/PhySO.sb
#!/usr/bin/bash

#SBATCH --account CARDIO-SL0-CPU
#SBATCH --partition cardio
#SBATCH --qos=cardio
#SBATCH --mem=28800
#SBATCH --time=12:00:00
#SBATCH --job-name=PhySO
#SBATCH --output=PhySO.o
#SBATCH --error=PhySO.e

export CEUADMIN=/usr/local/Cluster-Apps/ceuadmin

. /etc/profile.d/modules.sh
module load miniconda3/4.5.1 texlive
. /usr/local/Cluster-Apps/miniconda3/4.5.1/etc/profile.d/conda.sh
conda activate $CEUADMIN/PhySO
conda install -p $CEUADMIN/PhySO --file requirements.txt
conda install -p $CEUADMIN/PhySO --file requirements_display1.txt
pip install -r requirements_display2.txt
pip install -e .
EOL

function create()
{
 # This step is doable from a login node
 conda create -y -p $CEUADMIN/PhySO python=3.8
 # The following statements are all automatic recommendations
 ## conda update -n base -c defaults conda
 echo ". /usr/local/Cluster-Apps/miniconda3/4.5.1/etc/profile.d/conda.sh" >> ~/.bashrc
 ## All users
 sudo ln -s /usr/local/Cluster-Apps/miniconda3/4.5.1/etc/profile.d/conda.sh /etc/profile.d/conda.sh
 echo "conda activate" >> ~/.bashrc
}
```

where we have made it available from `/usr/local/Cluster-Apps/ceuadmin` with all the steps to be generated into ~/PhySO.sb, called with `sbatch`.

Note that `requirements.txt` includes `pytorch` for `conda install` but `torch` with `pip install -r requirements.txt`. It also appears that `dot2tex`, `pdflatex` (needs to be `pip install pdflatex`) and `pdf2image` are necessary. Some notes are available from `requirements_display2.txt`.

:star: :star: :star: It appears that there is conflict between `texlive/2015` from CSD3 and `texlive-core` so we execute `conda uninstall -p $PhySO texlive-core` to be in line with the former.

Tests of package loading and units follow suit from the documentation.

```bash
python -c 'import physo;print("OK")'
python -m unittest discover -p "*UnitTest.py"
```

Note that at the `Getting started` section Python session needs to be started followed by a statement `import numpy as np` to proceed.

## By-products

Besides `torch`, it is noticeable that `jupyterlab` and `scikit-learn` are also made available as dependencies. In fact, quite some packages are installed to `lib/python3.8/site-packages/`, leading to an overall size of ~7GB.

A full list is visible through `conda list`.

## A full test

Demos are available from `demo/` in forms of both `.ipynb` and `.py`.

This is extracted from README.md,

```python
import numpy as np
import physo

z = np.random.uniform(-10, 10, 50)
v = np.random.uniform(-10, 10, 50)
X = np.stack((z, v), axis=0)
y = 1.234*9.807*z + 1.234*v**2

# set 1. Symbolic regression with default hyperparameters.
expression, logs = physo.SR(X, y,
                            X_units = [ [1, 0, 0] , [1, -1, 0] ],
                            y_units = [2, -2, 1],
                            fixed_consts       = [ 1.      ],
                            fixed_consts_units = [ [0,0,0] ],
                            free_consts_units  = [ [0, 0, 1] , [1, -2, 0] ],
)
# set 2. Hyperparameters configurations.
expression, logs = physo.SR(X, y,
                            X_units = [ [1, 0, 0] , [1, -1, 0] ],
                            y_units = [2, -2, 1],
                            fixed_consts       = [ 1.      ],
                            fixed_consts_units = [ [0,0,0] ],
                            free_consts_units  = [ [0, 0, 1] , [1, -2, 0] ],
                            run_config = physo.config.config1.config1
)
# set 3. Selectable symbolic operations.
expression, logs = physo.SR(X, y,
                            X_names = [ "z"       , "v"        ],
                            X_units = [ [1, 0, 0] , [1, -1, 0] ],
                            y_name  = "E",
                            y_units = [2, -2, 1],
                            fixed_consts       = [ 1.      ],
                            fixed_consts_units = [ [0,0,0] ],
                            free_consts_names = [ "m"       , "g"        ],
                            free_consts_units = [ [0, 0, 1] , [1, -2, 0] ],
                            op_names = ["mul", "add", "sub", "div", "inv", "n2", "sqrt", "neg", "exp", "log", "sin", "cos"]
)

print(expression.get_infix_pretty(do_simplify=True))
print(expression.get_infix_latex(do_simplify=True))
print(expression.free_const_values.cpu().detach().numpy())

pareto_front_complexities, pareto_front_expressions, pareto_front_r, pareto_front_rmse = logs.get_pareto_front()
for i, prog in enumerate(pareto_front_expressions):
    # Showing expression
    print(prog.get_infix_pretty(do_simplify=True))
    # Showing free constant
    free_consts = prog.free_const_values.detach().cpu().numpy()
    for j in range (len(free_consts)):
        print("%s = %f"%(prog.library.free_const_names[j], free_consts[j]))
    # Showing RMSE
    print("RMSE = {:e}".format(pareto_front_rmse[i]))
    print("-------------")
```

Three sets of parameters are provided which no longer requires to be run separately. These are also wrapped as a [physo.ipynb](files/physo.ipynb) including outputs.

## fonts

This section is according to <https://alexanderlabwhoi.github.io/post/2021-03-missingfont/>.

```
rm ~/.cache/matplotlib -rf
conda install -p $PhySO -c conda-forge mscorefonts
```

and use them,

```pyton
import matplotlib
matplotlib.rcParams['font.family'] = "sans-serif"
matplotlib.rcParams['font.sans-serif'] = "Comic Sans MS"
```

This will reveal location of the default specification,

```python
import matplotlib
print(matplotlib.matplotlib_fname())
```

which in this case, `/usr/local/Cluster-Apps/ceuadmin/PhySO/lib/python3.8/site-packages/matplotlib/mpl-data/matplotlibrc`, where we make changes such as,

```
font.family:  sans-serif
font.sans-serif: Arial
pdf.fonttype: 42
```
