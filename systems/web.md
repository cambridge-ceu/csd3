---
sort: 12
---

# Web browsing

Advantages of browsing local files as web pages over plain files include improved file formatting, multimedia integration, interactive
and dynamic navigation. Suppose for instance our directory contains a `README.md` (as in a GitHub repository) which can be converted to
`README.html` via `pandoc`, then we can browse our directory as files + web page with `README.html` (allowing for explicit file
download), or a web page when `index.html` is created as a symbolic link to `README.html` (files are invisible unless explicit links are
given inside).

To proceed, we first start the web service, which is simply done as follows:

```bash
module load python/3.8.11/gcc/pqdmnzmw
python -m http.server 8080 &
```

assuming port number 8080 is available, e.g. `lsof -i :8080` gives no output.

The `firefox` browser available at `/usr/bin/firefox` is dysfunctional, so several alternatives are described below.

## chromium

We are then capable to work with `ceuadmin/chromium`:

```bash
module load ceuadmin/chromium
chrome http://localhost:8080 &
```

It might be helpful to clear browse history when `chrome` is repeatedly used, or to start a new profile, e.g.,

```bash
chrome --user-data-dir=/tmp/jhz22 http://localhost:8080 &
```

## edge

This is also ready to use,

```bash
module load ceuadmin/edge
edge http://localhost:8080
```

where the customized `edge` works properly, unlike its aliases `microsoft-edge` and `microsoft-edge-stable`.

## Cytoscape

This is an earlier attempt but somewhat clumsy.

```bash
module load ceuadmin/Cytoscape/3.9.1
Cytoscape &
```

using `Tools` --> `Open web page` for `http://127.0.0.1:8080`.
