---
sort: 12
---

# Web testing

We set to browse our pages hosted at `srcf/`. The default `firefox` browser is dysfunctional, so several alternatives are described here.

Assuming port number 8080 is available, e.g. `lsof -i :8080` gives no output, his is likely the simplest way to start the web service:

```bash
cd srcf
module load python/3.8.11/gcc/pqdmnzmw
python -m http.server 8080 &
```

## chromium

We are then capable to work with `ceuadmin/chromium`

```bash
module load ceuadmin/chromium
chrome http://localhost:8080
```

It might be helpful to clear browse history when chrome is repeatedly used, or to start a new profile.

```bash
chrome --user-data-dir=/tmp/jhz22
```

## edge

```bash
module load ceuadmin/edge
edge http://localhost:8080
```

Aliases to `edge` is `microsoft-edge` and `microsoft-edge-stable`.

## Cytoscape

This is an earlier attempt,

```bash
module load ceuadmin/Cytoscape/3.9.1
Cytoscape &
```

using `Tools` --> `Open web page` for `http://127.0.0.1:8080`.

which is somewhat clumsy.
