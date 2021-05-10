---
1: 22
---

# pandoc

Web: [https://pandoc.org/](https://pandoc.org/)

The latest release: [https://github.com/jgm/pandoc/releases/tag/2.13](https://github.com/jgm/pandoc/releases/tag/2.13)

Some applications requires the more recent version than those from CSD3; it is straightforward to install.

```bash
cd ${HPC_WORK}
wget -qO- https://github.com/jgm/pandoc/releases/download/2.13/pandoc-2.13-linux-amd64.tar.gz | tar xvfz - --strip-components=1
```

so that the executable file and documentation are made available from bin/ and share/ directories, respectively.
