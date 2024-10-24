---
sort: 12
---

# Web testing

This is surely among the simplest,

```bash
module load python/3.8.11/gcc/pqdmnzmw
python -m http.server 8080 &
```

assuming port number 8080 is avaiable. An attempt can be made with `Cytoscape`

```bash
cd srcf
module load ceuadmin/Cytoscape/3.9.1
Cytoscape &
```

using `Tools` --> `Open web page` for our pages hosted at `srcf/` via `http://127.0.0.1:8080`.
