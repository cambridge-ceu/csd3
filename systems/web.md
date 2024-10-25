---
sort: 12
---

# Web testing

This is likely the simplest,

```bash
module load python/3.8.11/gcc/pqdmnzmw
python -m http.server 8080 &
```

assuming port number 8080 is avaiable, e.g. `lsof -i :8080` gives no output. 

With a dysfunctional `firefox`, an attempt can be made with `Cytoscape`

```bash
cd srcf
module load ceuadmin/Cytoscape/3.9.1
Cytoscape &
```

using `Tools` --> `Open web page` for our pages hosted at `srcf/` via `http://127.0.0.1:8080`.

This is somewhat clumsy, and we appear capable to work with `ceuadmin/chrome`.
