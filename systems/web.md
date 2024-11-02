---
sort: 12
---

# Web browsing

`Browsing local files as web pages offers several advantages over plain files, including improved formatting and interactivity through HTML and CSS, enhanced navigation with menus and links, and dynamic content updates for a smoother experience. Web pages are cross-platform compatible, support multimedia integration, and include accessibility features. They also allow for easy content updates, better search functionality, and can implement security protocols, making them a more versatile and user-friendly option for accessing local content` (ChatGPT).

We set browse files hosted at `srcf/`.

The `firefox` browser available at `/usr/bin/firefox` is dysfunctional, so several alternatives are described here.

To proceed, we need to start the web service first, which is simply done as follows:

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

where the customized `edge` works properly, unlike its aliases `microsoft-edge` and `microsoft-edge-stable`.

## Cytoscape

This is an earlier attempt but somewhat clumsy.

```bash
module load ceuadmin/Cytoscape/3.9.1
Cytoscape &
```

using `Tools` --> `Open web page` for `http://127.0.0.1:8080`.
