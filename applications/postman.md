---
sort: 59
---

# postman

Web: <https://www.postman.com/>

## Latest

```bash
wget -qO- https://dl.pstmn.io/download/latest/linux64 -O latest.tar.gz
```

but this requires GLIBC 2.34.

## 10.21.0

This version works under GLIBC 2.28 but bundled with Electron -- some files are deleted to reduce the size from 1.2G to 914MB.

```bash
export version=10.21.0
cd $CEUADMIN
mkdir postman && cd postman
mkdir "$version" && cd "$version"
wget -qO- "https://dl.pstmn.io/download/version/${version}/linux64" | \
tar -xz --strip-components=1

# Go to the Postman app resources folder
cd /usr/local/Cluster-Apps/ceuadmin/postman/10.21.0/app/resources/app

# 1️⃣ Keep only the English locale (adjust 'en-US.pak' if you need another)
find locales -type f ! -name 'en-US.pak' -delete

# 2️⃣ Remove Electron debug symbol files (.pdb)
find ../../ -type f -name "*.pdb" -delete

# 3️⃣ Remove optional cache and temporary data
rm -rf node_modules/.cache
rm -rf swiftshader

# 4️⃣ Remove unnecessary high-res icons and oversized ICOs
find . -type f -name '*.icns' -delete
find . -type f -name '*.ico' -size +200k -delete

# 5️⃣ (Optional) Strip symbols from the main binary to save extra space
strip ../../Postman 2>/dev/null || true

export POSTMAN_DISABLE_AUTO_UPDATE=true
```
