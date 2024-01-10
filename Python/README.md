---
sort: 2
---

# Python packages

source: `{{ page.path }}`

This directory hosts some Python packages, though it is harder to separate them from other mainstream applications.

{% include list.liquid all=true %}

Special notes are given here regarding `biopython`, i.e.,

<https://biopython.org/>

with data from UniProt, e.g., APOB and A1BG,

```bash
wget https://rest.uniprot.org/uniprotkb/P04114.txt
wget https://rest.uniprot.org/uniprotkb/P04217.fasta

source ~/rds/public_databases/software/py38/bin/activate

python <<END
# all information
from Bio import SwissProt
with open('P04217.txt') as file:
    for record in SwissProt.parse(file):
        print(f"ID: {record.entry_name}, Description: {record.description}")
        for feature in record.features:
            print(feature)
        print("=" * 30)
        print("Sequence:")
        print(record.sequence)

# match and position
def match_sequence(fasta_file, search_string):
    sequences = SeqIO.to_dict(SeqIO.parse(fasta_file, 'fasta'))
    for sequence_id, sequence_record in sequences.items():
        if search_string in sequence_record.seq:
            print(f"Match found in sequence with ID: {sequence_id}")
            print(f"Sequence Description: {sequence_record.description}")
            print(f"Matched Substring: {search_string}")
            print("=" * 30)
            return True
    print(f"No match found for substring: {search_string}")
    return False

def find_matching_position(sequence, search_string):
    position = sequence.find(search_string)
    return position

fasta_file = 'P04217.fasta'
search_442688365 = 'TDGEGALSEPSATVTIEELAAPPPPVLMHHGESSQVLHPGNK'
match_sequence(fasta_file, search_442688365)

sequence = SeqIO.to_dict(SeqIO.parse(fasta_file, 'fasta'))
id = 'sp|P04217|A1BG_HUMAN'
amino_acid_sequence = sequence[id].seq
match_position = find_matching_position(amino_acid_sequence, search_442688365)
print(f"Match found at position: {match_position}")
END
```

so that the matched position is found at position 185.
