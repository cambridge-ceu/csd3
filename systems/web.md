---
sort: 12
---

# Web browsing

We set to browse our pages hosted at `srcf/`. The `firefox` browser available at `/usr/bin/firefox` is dysfunctional, so several alternatives are described here.

## Web service

This is required but not started by default, here is likely the simplest way to start:

```bash
cd srcf
module load python/3.8.11/gcc/pqdmnzmw
python -m http.server 8080 &
```

sssuming port number 8080 is available, e.g. `lsof -i :8080` gives no output.

## chromium

We are then capable to work with `ceuadmin/chromium`:

```bash
module load ceuadmin/chromium
chrome http://localhost:8080
```

It might be helpful to clear browse history when chrome is repeatedly used, or to start a new profile, e.g.,

```bash
chrome --user-data-dir=/tmp/jhz22
```

## edge

This is also ready to use,

```bash
module load ceuadmin/edge
edge http://localhost:8080
```

Aliases to `edge` is `microsoft-edge` and `microsoft-edge-stable`.

## Cytoscape

This is an earlier attempt but somewhat clumsy.

```bash
module load ceuadmin/Cytoscape/3.9.1
Cytoscape &
```

using `Tools` --> `Open web page` for `http://127.0.0.1:8080`.
