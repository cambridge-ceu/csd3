import pysam
import sys

def vcf_to_sloan15(vcf_path, output_path):
    vcf_in = pysam.VariantFile(vcf_path, "r")  # Auto-detects .vcf, .vcf.gz, .bcf :contentReference[oaicite:0]{index=0}
    samples = list(vcf_in.header.samples)
    
    with open(output_path, 'w') as out:
        # Write header row
        out.write("Locus\t" + "\t".join(samples) + "\n")
        
        # Iterate through each variant record
        for rec in vcf_in.fetch():  # Efficient iteration :contentReference[oaicite:1]{index=1}
            # Build locus identifier
            locus = f"{rec.contig}_{rec.pos}"
            
            # Skip if GT (genotype) format is not present
            if 'GT' not in rec.format.keys():
                continue
            
            # Map allele indices to actual bases (ref + alts)
            allele_map = [rec.ref] + list(rec.alts or [])
            
            row = [locus]
            for sample in samples:
                gt_tuple = rec.samples[sample].get('GT')
                if gt_tuple is None or any(a is None for a in gt_tuple):
                    row.append('--')
                else:
                    # Combine allele bases, preserving phasing direction is optional
                    bases = ''.join(allele_map[a] for a in gt_tuple)
                    row.append(bases)
            
            out.write("\t".join(row) + "\n")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print(f"Usage: {sys.argv[0]} <input.vcf or input.vcf.gz> <output.txt>", file=sys.stderr)
        sys.exit(1)
    
    vcf_path = sys.argv[1]
    output_path = sys.argv[2]
    vcf_to_sloan15(vcf_path, output_path)
