---
sort: 34
---

# gdal

## 3.10.3

This is built under CentOS 8 (icelake).

```bash
wget -qO- https://download.osgeo.org/gdal/3.10.3/gdal-3.10.3.tar.gz | \
tar xfz -
cd gdal-3.10.3/
mkdir build && cd build
module load ceuadmin/proj/7.2.1
cmake ..   -DCMAKE_INSTALL_PREFIX=$CEUADMIN/gdal/3.10.3 \
           -DCMAKE_BUILD_TYPE=Release \
           -DCMAKE_PREFIX_PATH=/usr/local/Cluster-Apps/ceuadmin/proj/7.2.1 \
           -DGDAL_USE_TIFF_INTERNAL=ON \
           -DGDAL_USE_GEOTIFF_INTERNAL=ON \
           -DBUILD_PYTHON_BINDINGS=OFF
make
make install
```
