---
sort: 48
---

# PRSoS

Web page: https://github.com/MeaneyLab/PRSoS.

```bash
git clone https://github.com/MeaneyLab/PRSoS.git
cd PRSoS
pip install –r requirements.txt
~/.local/bin/spark-submit --master local[*] PRSoS.py examples/example.vcf examples/gwasfile.txt test_output
```
