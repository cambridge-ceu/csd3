---
sort: 12
---

# Web testing

We set to browse our pages hosted at `srcf/`.

Assuming port number 8080 is available, e.g. `lsof -i :8080` gives no output, this is likely the simplest way to start the web service:

```bash
cd srcf
module load python/3.8.11/gcc/pqdmnzmw
python -m http.server 8080 &
```

We are then capable to work with `ceuadmin/chrome`

```bash
module load ceuadmin/chrome
chrome http://localhost:8080
```

in replace of a dysfunctional `firefox`.

An earlier attempt was made with `Cytoscape`

```bash
module load ceuadmin/Cytoscape/3.9.1
Cytoscape &
```

using `Tools` --> `Open web page` for `http://127.0.0.1:8080`.

which is somewhat clumsy.
