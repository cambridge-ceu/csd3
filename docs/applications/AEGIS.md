---
sort: 2
---

# AEGIS

Web: http://aegis.stanford.edu/

The installation follows the documentation but requires slight change,

```bash
# default Python 3.6
module load python

virtualenv py36
source py36/bin/activate
git clone https://github.com/junjiezhujason/aegis.git
cd aegis

# pip3 install -r requirements.txt
cat requirements.txt | \
grep -v MarkupSafe | \
xargs pip3 install

# setup
#!/usr/bin/bash
export PROJECT_PATH=/home/$USER/aegis/data
cd ${PROJECT_PATH}
# wget -qO- http://stanford.edu/~jjzhu/fileshare/aegis/local_20180719.tar.gz | tar -xvzf local_20180719.tar.gz
cd -
python3 main.py --lite --port 5001 --folder ${PROJECT_PATH} &
python3 main.py --port 5002 --folder ${PROJECT_PATH} &
firefox http://localhost:5002 &
```

as it appears that MarkupSafe could not be installed according to the predefined order.
