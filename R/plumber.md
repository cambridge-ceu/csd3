---
sort: 9
---

# R/plumber

## Installation

It requires R/sodium which in turn requires `libsodium`, [https://doc.libsodium.org/](https://doc.libsodium.org/).

```bash
wget -qO- https://download.libsodium.org/libsodium/releases/libsodium-1.0.18.tar.gz | \
tar xvfz -
cd libsodium-1.0.18
configure --prefix=${HPC_WORK}
make
make install
```

Following this, we could issue `Rscript -e "install.packages('plumber')"`.

## Example

This is adapted from [https://www.rplumber.io/](https://www.rplumber.io/).

We first create a file named [`plumber.R`](files/plumber.R) as follows,

```r
# plumber.R

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg="") {
  list(msg = paste0("The message is: '", msg, "'"))
}

#* Plot a histogram
#* @serializer png
#* @get /plot
function() {
  rand <- rnorm(100)
  hist(rand)
}

#* Return the sum of two numbers
#* @param a The first number to add
#* @param b The second number to add
#* @post /sum
function(a, b) {
  as.numeric(a) + as.numeric(b)
}
```

We could then start

```r
Rscript -e "library(plumber);pr('plumber.R') %>% pr_run(port=8000)"
```

and GET and POST as follows,

```bash
curl "http://localhost:8000/echo"
curl "http://localhost:8000/echo?msg=hello"
curl "http://localhost:8000/plot" | display # -o plot.png
curl --data "a=4&b=3" "http://localhost:8000/sum"
curl -H "Content-Type: application/json" --data '{"a":4, "b":5}' http://localhost:8000/sum
```
