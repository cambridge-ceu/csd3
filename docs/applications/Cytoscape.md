---
sort: 11
---

# Cytoscape

Web: [https://cytoscape.org/](https://cytoscape.org/).

GitHub: [https://github.com/cytoscape/cytoscape](https://github.com/cytoscape/cytoscape).

To start, we experiment with the latest version.

```bash
cd ${HPC_WORK}
wget https://github.com/cytoscape/cytoscape/releases/download/3.9.0/Cytoscape_3_9_0_unix.sh
module load openjdk-11.0.2-gcc-5.4.0-3dxltae
bash Cytoscape_3_9_0_unix.sh
cd bin
ln -s /rds/user/${USER}/hpc-work/Cytoscape_v3.9.0/cytoscape.sh
cytoscape.sh &
```
