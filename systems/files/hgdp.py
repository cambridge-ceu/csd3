import sys
import csv

def vcf_to_sloan15(vcf_path, output_path):
    with open(vcf_path, 'r') as f:
        for line in f:
            if line.startswith('#CHROM'):
                header = line.strip().split('\t')
                samples = header[9:]  # sample IDs
                print("Locus\t" + "\t".join(samples), file=open(output_path, 'w'))
                break

        for line in f:
            if line.startswith('#'):
                continue
            fields = line.strip().split('\t')
            chrom, pos, _, ref, alt, _, _, _, fmt = fields[:9]
            genotypes = fields[9:]

            # Build locus ID
            locus = f"{chrom}_{pos}"

            # Get genotype field index
            fmt_fields = fmt.split(':')
            gt_index = fmt_fields.index('GT') if 'GT' in fmt_fields else -1
            if gt_index == -1:
                continue

            allele_map = [ref] + alt.split(',')
            row = [locus]
            for sample in genotypes:
                parts = sample.split(':')
                gt = parts[gt_index]
                if gt in ('.', './.', '.|.'):
                    row.append('--')
                    continue
                alleles = gt.replace('|', '/').split('/')
                try:
                    bases = ''.join([allele_map[int(a)] for a in alleles])
                except:
                    bases = '--'
                row.append(bases)
            print("\t".join(row), file=open(output_path, 'a'))

# Example usage:
vcf_to_sloan15("data/examples/example-wgs.vcf", "sloan15_input.txt")
