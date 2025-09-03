---
sort: 50
---

# PLINK

As with GCTA, we cover direct download, source compilation but provision of detailed screen summary which can serve for lookup.

## Executables

Download from [https://www.cog-genomics.org/plink/1.9/](https://www.cog-genomics.org/plink/1.9/) or [https://www.cog-genomics.org/plink/2.0/](https://www.cog-genomics.org/plink/2.0/).

## Sources

This is useful for obtaining the latest version.

### 1.9

The stumbling point is zlib and it suffices with 1.2.11 on csd3. The location of `zlib.h`, i.e., `/usr/local/Cluster-Apps/zlib/1.2.11/include/zlib.h`, needs to be changed with `plink_common.h` and `pigz.c`. It also requires explicit with the whereabout of `libcblas.a` in our case at `${HPC_WORK}/lib`. One can follows instructions in `plink_first_compile` to download and install `zlib-1.2.11` but it is preferable to create a symbolic link.

Putting together, we have

```bash
ln -s /usr/local/Cluster-Apps/zlib/1.2.11 zlib-1.2.11
cd 1.9
# edit pigz.c and plink_common.h for ../zlib-1.2.11/include/zlib.h
make
/usr/local/software/archive/linux-scientific7-x86_64/gcc-9/gcc-6.5.0-dtb6lagchexqdijlx6xgkin3zlfddpzi/bin/g++ plink.o plink_assoc.o plink_calc.o plink_cluster.o plink_cnv.o plink_common.o plink_data.o plink_dosage.o plink_family.o plink_filter.o plink_glm.o plink_help.o plink_homozyg.o plink_lasso.o plink_ld.o plink_matrix.o plink_misc.o plink_perm.o plink_rserve.o plink_set.o plink_stats.o SFMT.o dcdflib.o pigz.o yarn.o Rconnection.o hfile.o bgzf.o  -L/usr/lib64/atlas -llapack -lblas -lcblas -latlas -lm -lpthread -ldl -L/usr/local/Cluster-Apps/zlib/1.2.11/lib/libz.so.1.2.11 -L$HPC_WORK/lib64 -o plink
```

Note that the last line is duplicated adding `-L/usr/local/Cluster-Apps/zlib/1.2.11/lib/libz.so.1.2.11 -L$HPC_WORK/lib64`.

### 2.0

Assume that LAPACK (in particular `libcblas.a`) is available.

It is necessary to modify `include/plink2_zstfile.h` to point to the whereabout of \<zstd.h\>, say "../zstd/lib/zstd.h" or "/rds/user/jhz22/hpc-work/include/zstd.h".
It still requires addition of -L${HPC_WORK}/lib64 for `libcblas.a`, which can be done by pasting and annexing to the last command from the console.

```bash
module load zlib/1.2.11
git clone https://github.com/chrchang/plink-ng
cd plink-ng/2.0
build.sh netlib
make
/usr/local/software/archive/linux-scientific7-x86_64/gcc-9/gcc-6.5.0-dtb6lagchexqdijlx6xgkin3zlfddpzi/bin/g++ include/SFMT.o libdeflate/lib/adler32.o libdeflate/lib/crc32.o libdeflate/lib/deflate_compress.o libdeflate/lib/deflate_decompress.o libdeflate/lib/gzip_compress.o libdeflate/lib/gzip_decompress.o libdeflate/lib/utils.o libdeflate/lib/zlib_compress.o libdeflate/lib/zlib_decompress.o libdeflate/lib/arm/arm_cpu_features.o libdeflate/lib/x86/x86_cpu_features.o zstd/lib/common/debug.o zstd/lib/common/entropy_common.o zstd/lib/common/zstd_common.o zstd/lib/common/error_private.o zstd/lib/common/xxhash.o zstd/lib/common/fse_decompress.o zstd/lib/common/pool.o zstd/lib/common/threading.o zstd/lib/compress/fse_compress.o zstd/lib/compress/hist.o zstd/lib/compress/huf_compress.o zstd/lib/compress/zstd_double_fast.o zstd/lib/compress/zstd_fast.o zstd/lib/compress/zstd_lazy.o zstd/lib/compress/zstd_ldm.o zstd/lib/compress/zstd_opt.o zstd/lib/compress/zstd_compress.o zstd/lib/compress/zstd_compress_literals.o zstd/lib/compress/zstd_compress_sequences.o zstd/lib/compress/zstd_compress_superblock.o zstd/lib/compress/zstdmt_compress.o zstd/lib/decompress/huf_decompress.o zstd/lib/decompress/zstd_decompress.o zstd/lib/decompress/zstd_ddict.o zstd/lib/decompress/zstd_decompress_block.o include/plink2_base.o include/plink2_bits.o include/pgenlib_misc.o include/pgenlib_read.o include/pgenlib_write.o include/plink2_bgzf.o include/plink2_stats.o include/plink2_string.o include/plink2_text.o include/plink2_thread.o include/plink2_zstfile.o plink2.o plink2_adjust.o plink2_cmdline.o plink2_common.o plink2_compress_stream.o plink2_data.o plink2_decompress.o plink2_export.o plink2_fasta.o plink2_filter.o plink2_glm.o plink2_help.o plink2_import.o plink2_ld.o plink2_matrix.o plink2_matrix_calc.o plink2_merge.o plink2_misc.o plink2_psam.o plink2_pvar.o plink2_random.o plink2_set.o -o bin/plink2  -llapack -lcblas -lblas -llapack -lcblas -lblas -lm -lpthread -lz -L$HPC_WORK/lib64
```

### ceuadmin/plink/2.00a3.3

Two elements are notable,

1. The last line is unneccesary, however, after adding `-L/usr/local/Cluster-Apps/ceuadmin/lapack/3.10.1/lib64` to the BLASFLAGS64 variable in `build.sh`.
2. The `gcc/6` module is required for 2.0.

Now these points to campus-wide location to enable non-CEU users (`-L/usr/local/Cluster-Apps/ceuadmin/lapack/3.10.1/lib64`) as well.

We have from `bin/plink2 -help`

```
PLINK v2.00a3 AVX2 (25 Oct 2021)               www.cog-genomics.org/plink/2.0/
(C) 2005-2021 Shaun Purcell, Christopher Chang   GNU General Public License v3

In the command line flag definitions that follow,
  * <angle brackets> denote a required parameter, where the text between the
    angle brackets describes its nature.
  * ['square brackets + single-quotes'] denotes an optional modifier.  Use the
    EXACT text in the quotes.
  * [{bar|separated|braced|bracketed|values}] denotes a collection of mutually
    exclusive optional modifiers (again, the exact text must be used).  When
    there are no outer square brackets, one of the choices must be selected.
  * ['quoted_text='<description of value>] denotes an optional modifier that
    must begin with the quoted text, and be followed by a value with no
    whitespace in between.  '|' may also be used here to indicate mutually
    exclusive options.
  * [square brackets without quotes or braces] denote an optional parameter,
    where the text between the brackets describes its nature.
  * An ellipsis (...) indicates that you may enter multiple arguments of the
    specified type.
  * A "column set descriptor" is either
    1. a comma-separated sequence of column set names; this is interpreted as
       the full list of column sets to include.
    2. a comma-separated sequence of column set names, all preceded by '+' or
       '-'; this is interpreted as a list of changes to the default.

  plink2 <input flag(s)...> [command flag(s)...] [other flag(s)...]
  plink2 --help [flag name(s)...]

Most PLINK runs require exactly one main input fileset.  The following flags
are available for defining its form and location:

  --pfile <prefix> ['vzs']  : Specify .pgen + .pvar[.zst] + .psam prefix.
  --pgen <filename>         : Specify full name of .pgen/.bed file.
  --pvar <filename>         : Specify full name of .pvar/.bim file.
  --psam <filename>         : Specify full name of .psam/.fam file.

  --bfile  <prefix> ['vzs'] : Specify .bed + .bim[.zst] + .fam prefix.
  --bpfile <prefix> ['vzs'] : Specify .pgen + .bim[.zst] + .fam prefix.

  --keep-autoconv ['vzs']   : When importing non-PLINK-binary data, don't
                              delete autogenerated fileset at end of run.

  --no-fid           : .fam file does not contain column 1 (family ID).
  --no-parents       : .fam file does not contain columns 3-4 (parents).
  --no-sex           : .fam file does not contain column 5 (sex).

  --vcf <filename> ['dosage='<field>]
  --bcf <filename> ['dosage='<field>] :
    Specify full name of .vcf{|.gz|.zst} or BCF2 file to import.
    * These can be used with --psam/--fam.
    * By default, dosage information is not imported.  To import the GP field
      (must be VCFv4.3-style 0..1, one probability per possible genotype), add
      'dosage=GP' (or 'dosage=GP-force', see below).  To import Minimac3-style
      DS+HDS phased dosage, add 'dosage=HDS'.  'dosage=DS' (or anything else
      for now) causes the named field to be interpreted as a Minimac3-style
      dosage.
      Note that, in the dosage=GP case, PLINK 2 collapses the probabilities
      down to dosages; you cannot use PLINK 2 to losslessly convert VCF
      FORMAT/GP data to e.g. BGEN format.  To make this more obvious, PLINK 2
      now errors out when dosage=GP is used on a file with a FORMAT/DS header
      line and --import-dosage-certainty wasn't specified, since dosage=DS
      extracts the same information more quickly in this situation.  You can
      suppress this error with 'dosage=GP-force'.
      In all of these cases, hardcalls are regenerated from scratch from the
      dosages.  As a consequence, variants with no GT field can now be
      imported; they will be assumed to contain only diploid calls when HDS is
      also absent.

  --data <filename prefix> <REF/ALT mode> ['gzs']
  --bgen <filename> <REF/ALT mode> ['snpid-chr']
  --gen <filename> <REF/ALT mode>
  --sample <filename> :
    Specify an Oxford-format dataset to import.  --data specifies a .gen[.zst]
    + .sample pair, while --bgen specifies a BGEN v1.1+ file.
    * If a BGEN v1.2+ file contains sample IDs, it may be imported without a
      companion .sample file.
    * With 'snpid-chr', chromosome codes are read from the 'SNP ID' field
      instead of the usual chromosome field.
    * The following REF/ALT modes are supported:
      'ref-first': The first allele for each variant is REF.
      'ref-last': The last allele for each variant is REF.
      'ref-unknown': The last allele for each variant is treated as
                     provisional-REF.

  --haps <filename> [{ref-first | ref-last}]
  --legend <filename> <chr code> :
    Specify .haps [+ .legend] file(s) to import.
    * When --legend is specified, it's assumed that the --haps file doesn't
      contain header columns.
    * On chrX, the second male column may contain dummy '-' entries.  (However,
      PLINK 2 currently cannot handle omitted male columns.)
    * If not used with --sample, new sample IDs are of the form 'per#/per#'.

  --map <filename>   : Specify full name of .map file.
  --import-dosage <allele dosage file> ['noheader'] ['id-delim='<char>]
                  ['skip0='<i>] ['skip1='<j>] ['skip2='<k>] ['dose1']
                  ['format='<m>] [{ref-first | ref-last}]
                  ['single-chr='<code>] ['chr-col-num='<#>]
                  ['pos-col-num='<#>] :
    Specify PLINK 1.x-style dosage file to import.
    * You must also specify a companion .psam/.fam file.
    * By default, PLINK assumes that the file contains a header line, which has
      'SNP' in (1-based) column i+1, 'A1' in column i+j+2, 'A2' in column
      i+j+3, and sample FID/IIDs starting from column i+j+k+4.  (i/j/k are
      normally zero, but can be changed with 'skip0', 'skip1', and 'skip2'
      respectively.  FID/IID are normally assumed to be separate tokens, but if
      they're merged into a single token you can specify the delimiter with
      'id-delim='.)  If such a header line is not present, use the 'noheader'
      modifier; samples will then be assumed to appear in the same order as
      they do in the .psam/.fam file.
    * You may specify a companion .map file.  If you do not,
      * 'single-chr=' can be used to specify that all variants are on the named
        chromosome.  Otherwise, you can use 'chr-col-num=' to read chromosome
        codes from the given (1-based) column number.
      * 'pos-col-num=' causes bp coordinates to be read from the given column
        number.
    * The 'format=' modifier lets you specify the number of values used to
      represent each dosage.  'format=1' normally indicates a single 0..2 A1
      expected count; 'dose1' modifies this to a 0..1 frequency.  'format=2'
      indicates a 0..1 homozygous A1 likelihood followed by a 0..1 het
      likelihood.  'format=3' indicates 0..1 hom A1, 0..1 het, 0..1 hom A2.
      'format=infer' (the default) infers the format from the number of columns
      in the first nonheader line.

  --dummy <sample ct> <SNP ct> [missing dosage freq] [missing pheno freq]
          [{acgt | 1234 | 12}] ['pheno-ct='<count>] ['scalar-pheno']
          ['phase-freq='<rate>] ['dosage-freq='<rate>]
    This generates a fake input dataset with the specified number of samples
    and SNPs.
    * By default, the missing dosage and phenotype frequencies are zero.
      These can be changed by providing 3rd and 4th numeric arguments.
    * By default, allele codes are As and Bs; this can be changed with the
      'acgt', '1234', or '12' modifier.
    * By default, one binary phenotype is generated.  'pheno-ct=' can be used
      to change the number of phenotypes, and 'scalar-pheno' causes these
      phenotypes to be normally distributed scalars.
    * By default, all genotypes/dosages are unphased.  To phase some of them,
      use 'phase-freq='.
    * By default, all dosages are in {0,1,2}.  To make some of them take on
      decimal values, use 'dosage-freq='.  (These dosages are affected by
      --hard-call-threshold and --dosage-erase-threshold.)

  --fa <filename>    : Specify full name of reference FASTA file.

Output files have names of the form 'plink2.<extension>' by default.  You can
change the 'plink2' prefix with

  --out <prefix>     : Specify prefix for output files.

Most runs also require at least one of the following commands:

  --rm-dup [mode] ['list']
    Remove all but one instance of each duplicate-ID variant (ignoring the
    missing ID), and (with the 'list' modifier) write a list of duplicated IDs
    to <output prefix>.rmdup.list.
    The following modes of operation are supported:
    * 'error' (default) causes this to error out when there's a genotype data
      or other mismatch between the records.  A list of affected IDs is written
      to <output prefix>.rmdup.mismatch.
    * 'retain-mismatch' causes all instances of a duplicate-ID variant to be
      retained when there's a genotype data or variant info mismatch; otherwise
      one instance is kept.  The .rmdup.mismatch file is also written.
    * 'exclude-mismatch' removes all instances of duplicate-ID mismatched
      variants instead.
    * 'exclude-all' causes all instances of duplicate-ID variants to be
      removed, even when the actual records are identical.
    * 'force-first' causes only the first instance of duplicate-ID variants to
      be kept, under all circumstances.

  --make-pgen ['vzs'] ['format='<code>] ['trim-alts'] ['erase-phase']
              ['erase-dosage'] ['fill-missing-from-dosage']
              ['pvar-cols='<col set desc>] ['psam-cols='<col set desc>]
  --make-bpgen ['vzs'] ['format='<code>] ['trim-alts'] ['erase-phase']
               ['erase-dosage'] ['fill-missing-from-dosage']
  --make-bed ['vzs'] ['trim-alts']
    Create a new PLINK 2 binary fileset (--make-pgen = .pgen + .pvar[.zst] +
    .psam, --make-bpgen = .pgen + .bim[.zst] + .fam).
    * Unlike the automatic text-to-binary converters (which only heed
      chromosome filters), this supports all of PLINK's filtering flags.
    * The 'vzs' modifier causes the variant file (.pvar/.bim) to be
      Zstd-compressed.
    * The 'format' modifier requests an uncompressed fixed-variant-width .pgen
      file.  (These do not directly support multiallelic variants.)  The
      following format code is currently supported:
        2: just like .bed, except with an extended (12-byte instead of 3-byte)
           header containing variant/sample counts, and rotated genotype codes
           (00 = hom ref, 01 = het, 10 = hom alt, 11 = missing).
    * The 'erase-phase' and 'erase-dosage' modifiers prevent phase and dosage
      information from being written to the new .pgen.
    * When a hardcall is missing but the corresponding dosage is present,
      'fill-missing-from-dosage' causes the (Euclidean-)nearest hardcall to be
      filled in, with ties broken in favor of the lower-index allele.
    * The first five columns of a .pvar file are always #CHROM/POS/ID/REF/ALT.
      Supported optional .pvar column sets are:
        xheader: All pre-#CHROM header lines (yeah, this is technically not a
                 column), except for possibly FILTER/INFO definitions when
                 those column(s) have been removed.  Without this, only the
                 #CHROM header line is kept.
        vcfheader: xheader, with additions to make it a valid VCF header.
        maybequal: QUAL.  Omitted if all remaining values are missing.
        qual: Force QUAL column to be written even when empty.
        maybefilter: FILTER.  Omitted if all remaining values are missing.
        filter: Force FILTER column to be written even when empty.
        maybeinfo: INFO.  Omitted if all remaining values are missing, or if
                   INFO/PR is the only subfield.
        info: Force INFO column to be written.
        maybecm: Centimorgan coordinate.  Omitted if all remaining values = 0.
        cm: Force CM column to be written even when empty.
      The default is xheader,maybequal,maybefilter,maybeinfo,maybecm.
    * Supported column sets for the .psam file are:
        maybefid: Family ID, '0' = missing.  Omitted if all values missing.
        fid: Force FID column to be written even when empty.
        maybesid: Source ID, '0' = missing.  Omitted if all values missing.
        sid: Force SID column to be written even when empty.
        maybeparents: Father and mother IIDs.  Omitted if all values missing.
        parents: Force PAT and MAT columns to be written even when empty.
        sex: '1' = male, '2' = female, 'NA' = missing.
        pheno1: First active phenotype.  If none, all column entries are set to
                the --output-missing-phenotype string.
        phenos: All active phenotypes, if any.  (Can be combined with pheno1 to
                force at least one phenotype column to be written.)
      The default is maybefid,maybesid,maybeparents,sex,phenos.

  --make-just-pvar ['zs'] ['cols='<column set descriptor>]
  --make-just-psam ['cols='<column set descriptor>]
  --make-just-bim ['zs']
  --make-just-fam
    Variants of --make-pgen/--make-bed which only write a new variant or sample
    file.  These don't always require an input genotype file.
    USE THESE CAUTIOUSLY.  It is very easy to desynchronize your binary
    genotype data and your sample/variant indexes if you use these commands
    improperly.  If you have any doubt, stick with --make-[b]pgen/--make-bed.

  --export <output format(s)...> [{01 | 12}] ['bgz'] ['id-delim='<char>]
           ['id-paste='<column set descriptor>] ['include-alt']
           ['omit-nonmale-y'] ['spaces'] ['vcf-dosage='<field>] ['ref-first']
           ['bits='<#>] ['sample-v2']
    Create a new fileset with all filters applied.  The following output
    formats are supported:
    (actually, only A, AD, A-transpose, bcf, bgen-1.x, haps, hapslegend,
    ind-major-bed, oxford, and vcf are implemented for now)
    * '23': 23andMe 4-column format.  This can only be used on a single
            sample's data (--keep may be handy), and does not support
            multicharacter allele codes.
    * 'A': Sample-major additive (0/1/2) coding, suitable for loading from R.
           If you need uncounted alleles to be named in the header line, add
           the 'include-alt' modifier.
    * 'AD': Sample-major additive (0/1/2) + dominant (het=1/hom=0) coding.
            Also supports 'include-alt'.
    * 'A-transpose': Variant-major 0/1/2.
    * 'beagle': Unphased per-autosome .dat and .map files, readable by early
                BEAGLE versions.
    * 'beagle-nomap': Single .beagle.dat file.
    * 'bgen-1.x': Oxford-format .bgen + .sample.  For v1.2/v1.3, sample
                  identifiers are stored in the .bgen (with id-delim and
                  id-paste settings applied), and default precision is 16-bit
                  (use the 'bits' modifier to reduce this).
    * 'bimbam': Regular BIMBAM format.
    * 'bimbam-1chr': BIMBAM format, with a two-column .pos.txt file.  Does not
                     support multiple chromosomes.
    * 'fastphase': Per-chromosome fastPHASE files, with
                   .chr-<chr #>.phase.inp filename extensions.
    * 'fastphase-1chr': Single .phase.inp file.  Does not support
                        multiple chromosomes.
    * 'haps', 'hapslegend': Oxford-format .haps + .sample[ + .legend].  All
                            data must be biallelic and phased.  When the 'bgz'
                            modifier is present, the .haps file is
                            block-gzipped.
    * 'HV': Per-chromosome Haploview files, with .chr-<chr #>{.ped,.info}
            filename extensions.
    * 'HV-1chr': Single Haploview .ped + .info file pair.  Does not support
                 multiple chromosomes.
    * 'ind-major-bed': PLINK 1 sample-major .bed (+ .bim + .fam).
    * 'lgen': PLINK 1 long-format (.lgen + .fam + .map), loadable with --lfile.
    * 'lgen-ref': .lgen + .fam + .map + .ref, loadable with --lfile +
                  --reference.
    * 'list': Single genotype-based list, up to 4 lines per variant.  To omit
              nonmale genotypes on the Y chromosome, add the 'omit-nonmale-y'
              modifier.
    * 'rlist': .rlist + .fam + .map fileset, where the .rlist file is a
                genotype-based list which omits the most common genotype for
                each variant.  Also supports 'omit-nonmale-y'.
    * 'oxford', 'oxford-v2': Oxford-format .gen + .sample.  When the 'bgz'
                             modifier is present, the .gen file is
                             block-gzipped.  'oxford' requests the original
                             .gen file format with 5 leading columns
                             (understood by older PLINK builds); 'oxford-v2'
                             requests the current 6-leading-column flavor.
    * 'ped': PLINK 1 sample-major (.ped + .map), loadable with --file.
    * 'compound-genotypes': Same as 'ped', except that the space between each
                            pair of same-variant allele codes is removed.
    * 'structure': Structure-format.
    * 'transpose': PLINK 1 variant-major (.tped + .tfam), loadable with
                   --tfile.
    * 'vcf',     : VCF (default version 4.3).  If PAR1 and PAR2 are present,
      'vcf-4.2',   they are automatically merged with chrX, with proper
      'bcf',       handling of chromosome codes and male ploidy.
      'bcf-4.2'    When the 'bgz' modifier is present, the VCF file is
                   block-gzipped.  (This always happens with BCF output.)
                   The 'id-paste' modifier controls which .psam columns are
                   used to construct sample IDs (choices are maybefid, fid,
                   iid, maybesid, and sid; default is maybefid,iid,maybesid),
                   while the 'id-delim' modifier sets the character between the
                   ID pieces (default '_').
                   Genotypes are always exported.  If you want to export a
                   sites-only VCF instead, see --make-pgen/--make-just-pvar's
                   'vcfheader' column set.
                   Dosages are not exported unless the 'vcf-dosage=' modifier
                   is present.  The following five dosage export modes are
                   supported:
                   'GP': genotype posterior probabilities (v4.3 only).
                   'DS': Minimac3-style dosages, omitted for hardcalls.
                   'DS-force': Minimac3-style dosages, never omit.
                   'HDS': Minimac3-style phased dosages, omitted for hardcalls
                          and unphased calls.  Also includes 'DS' output.
                   'HDS-force': Always report DS and HDS.
    In addition,
    * The '12' modifier causes alt1 alleles to be coded as '1' and ref alleles
      to be coded as '2', while '01' maps alt1 -> 0 and ref -> 1.
    * The 'spaces' modifier makes the output space-delimited instead of
      tab-delimited, whenever both are permitted.
    * For biallelic formats where it's unspecified whether the reference/major
      allele should appear first or second, --export defaults to second for
      compatibility with PLINK 1.9.  Use 'ref-first' to change this.
      (Note that this doesn't apply to the 'A', 'AD', and 'A-transpose'
      formats; use --export-allele to control which alleles are counted there.)
    * 'sample-v2' exports .sample files according to the QCTOOLv2 rather than
      the original specification.  Only one ID column is exported ('id-paste'
      and 'id-delim' settings apply), parental IDs are exported if present, and
      category names are preserved rather than converted to positive integers.

  --freq ['zs'] ['counts'] ['cols='<column set descriptor>] ['bins-only']
         ['refbins='<comma-separated bin boundaries> | 'refbins-file='<file>]
         ['alt1bins='<comma-separated bin boundaries> | 'alt1bins-file='<file>]
    Empirical allele frequency report.  By default, only founders are
    considered.  Dosages are taken into account (e.g. heterozygous haploid
    calls count as 0.5).
    Supported column sets are:
      chrom: Chromosome ID.
      pos: Base-pair coordinate.
      (ID is always present, and positioned here.)
      ref: Reference allele.
      alt1: Alternate allele 1.
      alt: All alternate alleles, comma-separated.
      reffreq: Reference allele frequency/dosage.
      alt1freq: Alt1 frequency/dosage.
      altfreq: Comma-separated frequencies/dosages for all alternate alleles.
      freq: Similar to altfreq, except ref is also included at the start.
      eq: Comma-separated <allele>=<freq> for all present alleles.  (If no
          alleles are present, the column contains a single '.'.)
      eqz: Same as eq, except zero-counts are included.
      alteq/alteqz: Same as eq/eqz, except reference allele is omitted.
      numeq: 0=<freq>,1=<freq>, etc.  Zero-counts are omitted.
      altnumeq: Same as numeq, except reference allele is omitted.
      machr2: Unphased MaCH imputation quality metric.
      minimac3r2: Phased Minimac3 imputation quality.
      nobs: Number of allele observations.
    The default is chrom,ref,alt,altfreq,nobs.
    Additional .afreq.{ref,alt1}.bins (or .acount.{ref,alt1}.bins with
    'counts') file(s) are generated when 'refbins='/'refbins-file=' or
    'alt1bins='/'alt1bins-file=' is present; these report the total number of
    frequencies or counts in each left-closed, right-open interval.  (If you
    only want these histogram(s), and not the main report, add 'bins-only'.)

  --geno-counts ['zs'] ['cols='<column set descriptor>]
    Variant-based hardcall genotype count report (considering both alleles
    simultaneously in the diploid case).  Nonfounders are now included; use
    --keep-founders if this is a problem.  Heterozygous haploid calls are
    treated as missing.
    Supported column sets are:
      chrom: Chromosome ID.
      pos: Base-pair coordinate.
      (ID is always present, and positioned here.)
      ref: Reference allele.
      alt1: Alternate allele 1.
      alt: All alternate alleles, comma-separated.
      homref: Homozygous-ref count.
      refalt1: Heterozygous ref-alt1 count.
      refalt: Comma-separated het ref-altx counts.
      homalt1: Homozygous-alt1 count.
      altxy: Comma-separated altx-alty counts, in (1/1)-(1/2)-(2/2)-(1/3)-...
             order.
      xy: Similar to altxy, except the reference allele is treated as alt0,
          and the sequence starts (0/0)-(0/1)-(1/1)-(0/2)-...
      hapref: Haploid-ref count.
      hapalt1: Haploid-alt1 count.
      hapalt: Comma-separated haploid-altx counts.
      hap: Similar to hapalts, except ref is also included at the start.
      numeq: 0/0=<hom ref ct>,0/1=<het ref-alt1>,1/1=<hom alt1>,...,0=<hap ref>
             etc.  Zero-counts are omitted.  (If all genotypes are missing, the
             column contains a single '.'.)
      missing: Number of missing genotypes.
      nobs: Number of (nonmissing) genotype observations.
    The default is chrom,ref,alt,homref,refalt,altxy,hapref,hapalt,missing.

  --sample-counts ['zs'] ['cols='<column set descriptor>]
    Sample-based hardcall genotype count report.
    * Unknown-sex samples are treated as female.
    * Heterozygous haploid calls (MT included) are treated as missing.
    * As with other PLINK 2 commands, SNPs that have not been left-normalized
      are counted as non-SNP non-symbolic.  (Use e.g. --normalize when that's a
      problem.)
    * Supported column sets are:
        maybefid: FID, if that column was present in the input.
        fid: Force FID column to be written even when absent in the input.
        (IID is always present, and positioned here.)
        maybesid: SID, if that column was present in the input.
        sid: Force SID column to be written even when absent in the input.
        sex: '1' = male, '2' = female, 'NA' = missing.
        hom: Homozygous genotype count.
        homref: Homozygous-ref genotype count.
        homalt: Homozygous-alt genotype count.
        homaltsnp: Homozygous-alt SNP count.
        het: Heterozygous genotype count.
        refalt: Heterozygous ref-altx genotype count.
        het2alt: Heterozygous altx-alty genotype count.
        hetsnp: Heterozygous SNP count.
        dipts: Diploid SNP transition count.
        ts: SNP transition count (excluding chrY for females).
        diptv: Diploid SNP transversion count.
        tv: SNP transversion count.
        dipnonsnpsymb: Diploid non-SNP, non-symbolic count.
        nonsnpsymb: Non-SNP, non-symbolic count.
        symbolic: Symbolic variant count.
        nonsnp: Non-SNP count.
        dipsingle: Number of singletons relative to this dataset, across just
                   diploid calls.  (Note that if the ALT allele in a chrX
                   biallelic variant appears in exactly one female and one
                   male, that counts as a singleton for just the female.)
        single: Number of singletons relative to this dataset.
        haprefwfemaley: Haploid-ref count, counting chrY for everyone.
        hapref: Haploid-ref count, excluding chrY for females.
        hapaltwfemaley: Haploid-alt count, counting chrY for everyone.
        hapalt: Haploid-alt count, excluding chrY for females.
        missingwfemaley: Missing call count, counting chrY for everyone.
        missing: Missing call count, excluding chrY for females.
      The default is maybefid,maybesid,homref,homaltsnp,hetsnp,dipts,diptv,
      dipnonsnpsymb,dipsingle,haprefwfemaley,hapaltwfemaley,missingwfemaley.
    * The 'hetsnp', 'dipts'/'ts'/'diptv'/'tv', 'dipnonsnpsymb'/'nonsnpsymb',
      'symbolic', and 'nonsnp' columns count each ALT allele in a heterozygous
      altx-alty call separately, since they can be of different subtypes.
      (I.e. if they are of the same subtype, the corresponding count is
      incremented by 2.)  As a consequence, these columns are unaffected by
      variant split/join.

  --missing ['zs'] [{sample-only | variant-only}]
            ['scols='<column set descriptor>] ['vcols='<column set descriptor>]
    Generate sample- and variant-based missing data reports (or just one report
    if 'sample-only'/'variant-only' is specified).
    Mixed MT hardcalls appear in the heterozygous haploid stats.
    Supported column sets in the sample-based report are:
      maybefid: FID, if that column was present in the input.
      fid: Force FID column to be written even when absent in the input.
      (IID is always present, and positioned here.)
      maybesid: SID, if that column was present in the input.
      sid: Force SID column to be written even when absent in the input.
      misspheno1: First active phenotype missing (Y/N)?  Always 'Y' if no
                  phenotypes are loaded.
      missphenos: A Y/N column for each loaded phenotype.  (Can be combined
                  with misspheno1 to force at least one such column.)
      nmissdosage: Number of missing dosages.
      nmiss: Number of missing hardcalls, not counting het haploids.
      nmisshh: Number of missing hardcalls, counting het haploids.
      hethap: Number of heterozygous haploid hardcalls.
      nobs: Denominator (male count on chrY, otherwise total sample count).
      fmissdosage: Missing dosage rate.
      fmiss: Missing hardcall rate, not counting het haploids.
      fmisshh: Missing hardcall rate, counting het haploids.
    The default is maybefid,maybesid,missphenos,nmiss,nobs,fmiss.
    Supported column sets in the variant-based report are:
      chrom: Chromosome ID.
      pos: Base-pair coordinate.
      (ID is always present, and positioned here.)
      ref: Reference allele.
      alt1: Alternate allele 1.
      alt: All alternate alleles, comma-separated.
      nmissdosage: Number of missing dosages.
      nmiss: Number of missing hardcalls, not counting het haploids.
      nmisshh: Number of missing hardcalls, counting het haploids.
      hethap: Number of heterozygous haploid calls.
      nobs: Number of potentially valid calls.
      fmissdosage: Missing dosage rate.
      fmiss: Missing hardcall rate, not counting het haploids.
      fmisshh: Missing hardcall rate, counting het haploids.
      fhethap: Heterozygous haploid rate.
    The default is chrom,nmiss,nobs,fmiss.

  --hardy ['zs'] ['midp'] ['redundant'] ['cols='<column set descriptor>]
    Hardy-Weinberg exact test p-value report(s).
    * By default, only founders are considered; change this with --nonfounders.
    * chrX is now omitted from the main <output prefix>.hardy report.  Instead,
      (if present) it gets its own <output prefix>.hardy.x report based on the
      method described in Graffelman J, Weir BS (2016) Hardy-Weinberg
      equilibrium and the X chromosome.
    * For variants with k alleles where k>2, k separate 'biallelic' tests are
      performed, each reported on its own line.  However, biallelic variants
      are normally reported on a single line, since the counts/frequencies
      would be mirror-images and the p-values would be the same.  You can add
      the 'redundant' modifier to force biallelic variant results to be
      reported on two lines for parsing convenience.
    * There is currently no special handling of case/control phenotypes.
    Supported column sets are:
      chrom: Chromosome ID.
      pos: Base-pair coordinate.
      (ID is always present, and positioned here.)
      ref: Reference allele.
      alt1: Alternate allele 1.
      alt: All alternate alleles, comma-separated.
      (A1 is always present, and positioned here.)
      ax: Non-A1 allele(s), comma-separated.
      gcounts: Hom-A1 count, total number of het-A1 calls, and total number of
               nonmissing calls with no copies of A1.  On chrX, these are
               followed by male A1 and male non-A1 counts.
      gcount1col: gcounts values in a single comma-separated column.
      hetfreq: Observed and expected het-A1 frequencies.
      sexaf: Female and male A1 observed allele frequencies (chrX only).
      femalep: Female-only p/midp-value (chrX only).
      p: Hardy-Weinberg equilibrium exact test p/midp-value.
    The default is chrom,ax,gcounts,hetfreq,sexaf,p.

  --het ['zs'] ['small-sample'] ['cols='<column set descriptor>]
    Inbreeding coefficient report.  Supports multiallelic variants.
    * This function requires decent MAF estimates.  If there are very few
      samples in your immediate fileset, --read-freq is practically mandatory
      since imputed MAFs are wildly inaccurate in that case.
    * It's usually best to perform this calculation on a variant set in
      approximate linkage equilibrium.
    * By default, --het omits the n/(n-1) multiplier in Nei's expected
      homozygosity formula.  The 'small-sample' modifier causes it to be
      included, while forcing --het to use MAFs imputed from founders in the
      immediate dataset.
    Supported column sets are:
      maybefid: FID, if that column was present in the input.
      fid: Force FID column to be written even when absent in the input.
      (IID is always present, and positioned here.)
      maybesid: SID, if that column was present in the input.
      sid: Force SID column to be written even when absent in the input.
      hom: Observed and expected numbers of homozygous genotypes.
      het: Observed and expected numbers of heterozygous genotypes.
      nobs: Number of (nonmissing) genotype observations.
      f: Method-of-moments F coefficient estimate.
    The default is maybefid,maybesid,hom,nobs,f.

  --fst <categorical or binary phenotype name> ['method='<method name>]
        ['blocksize='<jackknife block size>] ['cols='<column set descriptor>]
        ['report-variants'] ['zs'] ['vcols='<column set descriptor>]
        ['base='<pop. ID> | 'ids='<pop. ID> | 'file='<pop.-ID-pair file>]
        [other population ID(s) for base=/ids=...]
    Estimate Wright's Fst between pairs of populations.
    * Two methods are supported:
      * 'hudson': Bhatia G, Patterson N, Sankararaman S, Price AL (2013)
                  Estimating and interpreting F_{ST}: The impact of rare
                  variants.  This is now the default.
      * 'wc': Weir BS, Cockerham CC (1984) Estimating F-statistics for the
              analysis of population structure.
    * To get block-jackknife-based standard error estimates, provide a
      blocksize= value.
    * There is only one optional column set in the main summary:
        (POP1 and POP2 are always present, and positioned here.)
        nobs: Number of variants with valid Fst estimates.
        (HUDSON_FST or WC_FST is always present, and positioned here.)
        (SE is present if blocksize= specified, and positioned here.)
      nobs is not included by default.
    * You can request per-variant Fst estimates with the 'report-variants'
      modifier; this generates a separate output file for each population pair.
      Supported per-variant report column sets are:
        chrom: Chromosome ID.
        pos: Base-pair coordinate.
        (ID is always present, and positioned here.)
        ref: Reference allele.
        alt: All alternate alleles, comma-separated.
        nobs: Number of (nonmissing) genotype observations across pop pair.
        nallele: Number of nonmissing alleles.
        fstfrac: Numerator and denominator of Fst estimate.
        fst: Fst estimate.
      The default is chrom,pos,nobs,fst.
    * By default, all pairs of populations are compared.  If you only want to
      compare some pairs, there are three ways to do this.
      * base= specifies one base population to be compared with all others; or
        if you specify more population ID(s) afterward, just the other
        populations you've listed.
      * ids= specifies an all-vs.-all comparison within the given set of
        populations.
      * file= specifies a file containing one population pair per line.
      Note that 'base='/'ids='/'file=' must be positioned after all modifiers.

  --indep-pairwise <window size>['kb'] [step size (variant ct)]
                   <unphased-hardcall-r^2 threshold>
    Generate a list of variants in approximate linkage equilibrium.
    * For multiallelic variants, major allele counts are used in the r^2
      computation.
    * With the 'kb' modifier, the window size is in kilobase instead of variant
      count units.  (Pre-'kb' space is optional, i.e.
      "--indep-pairwise 500 kb 0.5" and "--indep-pairwise 500kb 0.5" have the
      same effect.)
    * The step size now defaults to 1 if it's unspecified, and *must* be 1 if
      the window is in kilobase units.
    * Note that you need to rerun PLINK using --extract or --exclude on the
      .prune.in/.prune.out file to apply the list to another computation... and
      as with other applications of --extract/--exclude, duplicate variant IDs
      are a problem.  --indep-pairwise still runs to completion for now when
      duplicate variant IDs are present, but that will become an error in alpha
      3.

  --ld <variant ID> <variant ID> ['dosage'] ['hwe-midp']
    This displays diplotype frequencies, r^2, and D' for a single pair of
    variants.
    * For multiallelic variants, major allele counts/dosages are used.
    * Phase information is used when both variants are on the same chromosome.
    * When there is at least one sample with unphased het calls for both
      variants, diplotype frequencies are estimated using the Hill equation.
      If there are multiple biologically possible local maxima, all are
      displayed, along with HWE exact test statistics.
    * By default, only hardcalls are considered.  Add the 'dosage' modifier if
      you want dosages to be taken into account.  (In the diploid case, an
      unphased dosage of x is interpreted as P(0/0) = 1 - x, P(0/1) = x when x
      is in 0..1.)

  --sample-diff ['id-delim='<char>] ['dosage' | 'dosage='<tolerance>]
                ['include-missing'] [{pairwise | counts-only}]
                ['fname-id-delim='<c>] ['zs'] ['cols='<column set descriptor>]
                ['counts-cols='<column set descriptor>]
                {base= | ids=}<sample ID> <other sample ID(s)...>
  --sample-diff ['id-delim='<char>] ['dosage' | 'dosage='<tolerance>]
                ['include-missing'] [{pairwise | counts-only}]
                ['fname-id-delim='<c>] ['zs'] ['cols='<column set descriptor>]
                ['counts-cols='<column set descriptor>] file=<ID-pair file>
    (alias: --sdiff)
    Report discordances and discordance-counts between pairs of samples.  If
    chrX or chrY is present, sex must be defined and consistent.
    * There are three ways to specify which sample pairs to compare.  To
      compare a single baseline sample against some others, start the
      (space-delimited) sample ID list with 'base='.  To perform an all-vs.-all
      comparison, start it with 'ids=' instead.  To compare sample pairs listed
      in a file, use 'file='.
      Note that 'base='/'ids='/'file=' must be positioned after all modifiers.
    * Sample IDs are interpreted as if they were in a VCF header line, with
      'id-delim=' having the usual effect.
    * By default, comparisons are based on hardcalls.  Use 'dosage' to compare
      dosages instead; you can combine this with a tolerance in [0, 0.5).
    * By default, if one genotype is missing and the other isn't, that doesn't
      count as a difference; this can be changed with 'include-missing'.
    * By default, a single main report is written to
      <output prefix>[.<base ID>].sdiff.  To write separate pairwise
      <output prefix>.<ID1>.<ID2>.sdiff reports for each compared ID pair, add
      the 'pairwise' modifier.  To omit the main report, add the 'counts-only'
      modifier.  (Note that, if you're only interested in nonmissing autosomal
      biallelic hardcalls, --make-king-table provides a more efficient way to
      compute just counts.)
    * By default, if an output filename has a multipart sample ID, the parts
      will be delimited by '_'; use 'fname-id-delim=' to change this.
    Supported main-report column sets are:
      chrom: Chromosome ID.
      pos: Base-pair coordinate.
      (Variant ID is always present, and positioned here.)
      ref: Reference allele.
      alt: All alternate alleles, comma-separated.
      maybefid: FID1/FID2, if that column was in the input.  Requires 'id'.
      fid: Force FID1/FID2 even when FID was absent in the input.
      id: IID1/IID2.
      maybesid: SID1/SID2, if that column was in the input.  Requires 'id'.
      sid: Force SID1/SID2 even when SID was absent in the input.
      geno: Unphased GT or DS for the two samples.
    The default is usually chrom,pos,ref,alt,maybefid,id,maybesid,geno; the
    sample IDs are removed from the default in 'pairwise' mode.
    Supported discordance-count-summary column sets are:
      maybefid: FID1/FID2, if that column was in the input.
      fid: Force FID1/FID2 even when FID was absent in the input.
      (IID1/IID2 are always present.)
      maybesid: SID1/SID2, if that column was in the input.
      sid: Force SID1/SID2 even when SID was absent in the input.
      nobs: Number of variants considered.  This includes variants where one or
            both variants are missing iff 'include-missing' was specified.
      nobsibs: ibs0+ibs1+ibs2.
      ibs0: Number of diploid variants with no common hardcall alleles.
      ibs1: Number of diploid variants with exactly 1 common hardcall allele.
      ibs2: Number of diploid variants with both hardcall alleles matching.
      halfmiss: Number of variants with exactly 1 missing genotype/dosage.
                Ignored without 'include-missing'.
      diff: Total number of differences.
    The default is maybefid,maybesid,nobs,halfmiss,diff.

  --make-king [{square | square0 | triangle}] [{zs | bin | bin4}]
    KING-robust kinship estimator, described by Manichaikul A, Mychaleckyj JC,
    Rich SS, Daly K, Sale M, Chen WM (2010) Robust relationship inference in
    genome-wide association studies.  By default, this writes a
    lower-triangular tab-delimited table of kinship coefficients to
    <output prefix>.king, and a list of the corresponding sample IDs to
    <output prefix>.king.id.  The first row of the .king file contains a single
    <genome 1-genome 2> kinship coefficient, the second row has the
    <genome 1-genome 3> and <genome 2-genome 3> kinship values in that order,
    etc.
    * Only autosomes are currently considered.
    * Pedigree information is currently ignored; the between-family estimator
      is used for all pairs.
    * For multiallelic variants, REF allele counts are used.
    * If the 'square' or 'square0' modifier is present, a square matrix is
      written instead; 'square0' fills the upper right triangle with zeroes.
    * If the 'zs' modifier is present, the .king file is Zstd-compressed.
    * If the 'bin' modifier is present, a binary (square) matrix of
      double-precision floating point values, suitable for loading from R, is
      instead written to <output prefix>.king.bin.  ('bin4' specifies
      single-precision numbers instead.)  This can be combined with 'square0'
      if you still want the upper right zeroed out, or 'triangle' if you don't
      want to pad the upper right at all.
    * The computation can be subdivided with --parallel.
  --make-king-table ['zs'] ['counts'] ['rel-check'] ['cols='<col set descrip.>]
    Similar to --make-king, except results are reported in KING's original
    .kin0 text table format (with minor changes, e.g. row order is more
    friendly to incremental addition of samples), --king-table-filter can be
    used to restrict the report to high kinship values, and the 'rel-check'
    modifier can be used to restrict to same-FID pairs.
    Supported column sets are:
      maybefid: FID1/FID2, if that column was in the input.  Requires 'id'.
      fid: Force FID1/FID2 even when FID was absent in the input.
      id: IID1/IID2.
      maybesid: SID1/SID2, if that column was in the input.  Requires 'id'.
      sid: Force SID1/SID2 even when SID was absent in the input.
      nsnp: Number of variants considered (autosomal, neither call missing).
      hethet: Proportion/count of considered call pairs which are het-het.
      ibs0: Proportion/count of considered call pairs which are opposite homs.
      ibs1: HET1_HOM2 and HET2_HOM1 proportions/counts.
      kinship: KING-robust between-family kinship estimator.
    The default is maybefid,id,maybesid,nsnp,hethet,ibs0,kinship.
    hethet/ibs0/ibs1 values are proportions unless the 'counts' modifier is
    present.  If id is omitted, a .kin0.id file is also written.

  --make-rel ['cov'] ['meanimpute'] [{square | square0 | triangle}]
             [{zs | bin | bin4}]
    Write a lower-triangular variance-standardized relationship matrix to
    <output prefix>.rel, and corresponding IDs to <output prefix>.rel.id.
    * This computation assumes that variants do not have very low MAF, or
      deviate greatly from Hardy-Weinberg equilibrium.
    * Also, it's usually best to perform this calculation on a variant set in
      approximate linkage equilibrium.
    * The 'cov' modifier replaces the variance-standardization step with basic
      mean-centering, causing a covariance matrix to be calculated instead.
    * The computation can be subdivided with --parallel.
  --make-grm-list ['cov'] ['meanimpute'] ['zs'] [{id-header | iid-only}]
  --make-grm-bin ['cov'] ['meanimpute'] [{id-header | iid-only}]
    --make-grm-list causes the relationships to be written to GCTA's original
    list format, which describes one pair per line, while --make-grm-bin writes
    them in GCTA 1.1+'s single-precision triangular binary format.  Note that
    these formats explicitly report the number of valid observations (where
    neither sample has a missing call) for each pair, which is useful input for
    some scripts.

  --pca [count] [{approx | meanimpute}] ['scols='<col set descriptor>]
  --pca [{allele-wts | biallelic-var-wts}] [count] [{approx | meanimpute}]
        ['vzs'] ['scols='<col set descriptor>] ['vcols='<col set descriptor>]
    Extracts top principal components from the variance-standardized
    relationship matrix.
    * It is usually best to perform this calculation on a variant set in
      approximate linkage equilibrium, with no very-low-MAF variants.
    * By default, 10 PCs are extracted; you can adjust this by passing a
      numeric argument.  (Note that 10 is lower than the PLINK 1.9 default of
      20; this is due to the randomized algorithm's memory footprint growing
      quadratically w.r.t. the PC count.)
    * The 'approx' modifier causes the standard deterministic computation to be
      replaced with the randomized algorithm originally implemented for
      Galinsky KJ, Bhatia G, Loh PR, Georgiev S, Mukherjee S, Patterson NJ,
      Price AL (2016) Fast Principal-Component Analysis Reveals Convergent
      Evolution of ADH1B in Europe and East Asia.  This can be a good idea when
      you have >5k samples, and is almost required with >50k.
    * The randomized algorithm always uses mean imputation for missing genotype
      calls.  For comparison purposes, you can use the 'meanimpute' modifier to
      request this behavior for the standard computation.
    * 'scols=' can be used to customize how sample IDs appear in the .eigenvec
      file.  (maybefid, fid, maybesid, and sid supported; default is
      maybefid,maybesid.)
    * The 'allele-wts' modifier requests an additional one-line-per-allele
      .eigenvec.allele file with PCs expressed as allele weights instead of
      sample weights.  When it's present, 'vzs' causes the .eigenvec.allele
      file to be Zstd-compressed.
      'vcols=' can be used to customize the report columns; supported column
      sets are:
        chrom: Chromosome ID.
        pos: Base-pair coordinate.
        (ID is always present, and positioned here.)
        ref: Reference allele.
        alt1: Alternate allele 1.
        alt: All alternate alleles, comma-separated.
        (A1 is always present, and positioned here.)
        ax: Non-A1 alleles, comma-separated.
        (PCs are always present, and positioned here.)
      Default is chrom,ref,alt.
    * For datasets with no multiallelic variants, the 'biallelic-var-wts'
      modifier requests the old .eigenvec.var format, which only reports
      weights for major alleles.  (These weights are 2x the corresponding
      .eigenvec.allele weights.)  Supported column sets are:
        chrom: Chromosome ID.
        pos: Base-pair coordinate.
        (ID is always present, and positioned here.)
        ref: Reference allele.
        alt1: Alternate allele 1.
        alt: All alternate alleles, comma-separated.
        maj: Major allele.
        nonmaj: Minor allele.
        (PCs are always present, and positioned here.  Signs are w.r.t. the
        major, not necessarily reference, allele.)
      Default is chrom,maj,nonmaj.

  --king-cutoff [.king.bin + .king.id fileset prefix] <threshold>
    Exclude one member of each pair of samples with KING-robust kinship greater
    than the given threshold.  Remaining/excluded sample IDs are written to
    <output prefix>.king.cutoff.in.id + .king.cutoff.out.id.
    If present, the .king.bin file must be triangular (either precision is ok).

  --write-covar ['cols='<column set descriptor>]
    If covariates are defined, an updated version (with all filters applied) is
    automatically written to <output prefix>.cov whenever --make-pgen,
    --make-just-psam, --export, or a similar command is present.  However, if
    you do not wish to simultaneously generate a new sample file, you can use
    --write-covar to just produce a pruned covariate file.
    Supported column sets are:
      maybefid: FID, if that column was in the input.
      fid: Force FID column to be written even when absent in the input.
      maybesid: SID, if that column was in the input.
      sid: Force SID column to be written even when absent in the input.
      maybeparents: Father/mother IIDs ('0' = missing), if columns in input.
      parents: Force PAT/MAT columns to be written even when absent in input.
      sex: '1' = male, '2' = female, 'NA' = missing.
      pheno1: First active phenotype.  If none, all column entries are set to
              the --output-missing-phenotype string.
      phenos: All active phenotypes, if any.  (Can be combined with pheno1 to
              force at least one phenotype column to be written.)
      (Covariates are always present, and positioned here.)
    The default is maybefid,maybesid.

  --pmerge <.pgen/.bed filename> <.pvar/.bim> <.psam/.fam>
  --pmerge <.pgen + .pvar + .psam fileset prefix> ['vzs']
    Merge the given fileset with the initially loaded fileset, writing the
    result to <output prefix>.pgen + .pvar + .psam.
  --pmerge-list <filename> [mode]
    Merge all filesets named in the text file.  Also merge with the initially
    loaded fileset if one was specified.
    When a line in the text file contains three entries, they are interpreted
    as full filenames for a binary fileset (.pgen/.bed, then .pvar/.bim, then
    .psam/.fam).  If it contains exactly one entry, its interpretation depends
    on the mode:
    * 'bfile': Prefix for .bed + .bim + .fam fileset.
    * 'bpfile': Prefix for .pgen + .bim + .fam fileset.
    * 'pfile' (default): Prefix for .pgen + .pvar + .psam fileset.
    * 'pfile-vzs': Prefix for .pgen + .pvar.zst + .psam fileset.
    For both --pmerge and --pmerge-list:
    * All input filesets must be sorted by position, and have the same
      chromosome order.  (When this isn't true, use --make-pgen + --sort-vars
      on each fileset first.)
    * Variants are only merged if their IDs AND positions match.  (This is a
      change from PLINK 1.x.)

  --pgen-diff <.pgen/.bed filename> <.pvar/.bim> <.psam/.fam>
              ['include-missing'] ['zs'] ['dosage' | 'dosage='<tolerance>]
              ['cols='<column set descriptor>]
  --pgen-diff <.pgen + .pvar + .psam prefix> ['vzs'] ['include-missing'] ['zs']
              ['dosage' | 'dosage='<tolerance>] ['cols='<col set descriptor>]
    Report unphased genotype/dosage differences in the intersection of two
    filesets.  (Sample and variant filters are also applied.)
    * If chrX or chrY is present, sex must be defined and consistent.
    * Variants are only compared if their IDs AND positions match.  An error
      is reported if any such match is not unique.
    * By default, comparisons are based on hardcalls.  Use 'dosage' to compare
      dosages instead; you can combine this with a tolerance in [0, 0.5).
    * By default, if one genotype is missing and the other isn't, that doesn't
      count as a difference; this can be changed with 'include-missing'.
    Supported column sets are:
      chrom: Chromosome ID.
      pos: Base-pair coordinate.
      id: Variant ID.
      ref: Reference allele.
      alt: All alternate alleles across both filesets, comma-separated.
      maybefid: FID, if that column was present in the input.
      fid: Force FID column to be written even when absent in the input.
      (IID is always present, and positioned here.)
      maybesid: SID, if that column was present in the input.
      sid: Force SID column to be written even when absent in the input.
      geno: Unphased GT or DS.
    The default is id,maybefid,maybesid,geno.

  --write-samples
    Report IDs of all samples which pass your filters/inclusion thresholds.

  --write-snplist ['zs'] ['allow-dups']
    List all variants which pass your filters/inclusion thresholds.  Unless the
    'allow-dups' modifier is provided, this now errors out when duplicate
    variant ID(s) remain.

  --glm ['zs'] ['omit-ref'] [{sex | no-x-sex}] ['log10'] ['pheno-ids']
        [{genotypic | hethom | dominant | recessive | hetonly}] ['interaction']
        ['hide-covar'] ['skip-invalid-pheno'] ['allow-no-covars']
        [{intercept | cc-residualize | firth-residualize}]
        [{no-firth | firth-fallback | firth}] ['cols='<col set desc>]
        ['local-covar='<file>] ['local-psam='<file>]
        ['local-pos-cols='<key col #s> | 'local-pvar='<file>] ['local-haps']
        ['local-omit-last' | 'local-cats[0]='<category ct>]
    Basic association analysis on quantitative and/or case/control phenotypes.
    For each variant, a linear (for quantitative traits) or logistic (for
    case/control) regression is run with the phenotype as the dependent
    variable, and nonmajor allele dosage(s) and a constant-1 column as
    predictors.
    * There is usually an additive effect line for every nonmajor allele, and
      no such line for the major allele.  To omit REF alleles instead of major
      alleles, add the 'omit-ref' modifier.  (When performing interaction
      testing, this tends to cause the multicollinearity check to fail for
      low-ref-frequency variants.)
    * By default, sex (male = 1, female = 2; note that this is a change from
      PLINK 1.x) is automatically added as a predictor for X chromosome
      variants, and no others.  The 'sex' modifier causes it to be added
      everywhere (except chrY), while 'no-x-sex' excludes it entirely.
    * The 'log10' modifier causes p-values to be reported in -log10(p) form.
    * 'pheno-ids' causes the samples used in each set of regressions to be
      written to an .id file.  (When the samples differ on chrX or chrY, .x.id
      and/or .y.id files are also written.)
    * The 'genotypic' modifier adds an additive effect/dominance deviation 2df
      joint test (0-2 and 0..1..0 coding), while 'hethom' uses 0..0..1 and
      0..1..0 coding instead.
    * 'dominant' and 'recessive' specify a model assuming full dominance or
      recessiveness, respectively, for the ref allele.  I.e. the genotype
      column is recoded as 0..1..1 or 0..0..1, respectively.
    * 'hetonly' replaces the genotype column with a dominance-deviation column.
    * 'interaction' adds genotype x covariate interactions to the model.  Note
      that this tends to produce 'NA' results (due to the multicollinearity
      check) when the reference allele is 'wrong'; --maj-ref can be used to
      enable analysis of those variants.
    * Additional predictors can be added with --covar.  By default, association
      statistics are reported for all nonconstant predictors; 'hide-covar'
      suppresses covariate-only results, while 'intercept' causes intercepts
      to be reported.
      Since running --glm without at least e.g. principal component covariates
      is usually an analytical mistake, the 'allow-no-covars' modifier is now
      required when you're intentionally running --glm without a covariate
      file.
    * By default, if the current phenotype and covariates are such that every
      regression on a chromosome will fail, PLINK 2 errors out.  To just skip
      the phenotype or chromosome instead, add the 'skip-invalid-pheno'
      modifier.
    * There are now three regression modes for case/control phenotypes:
      * 'no-firth' requests PLINK 1.x's behavior, where a NA result is reported
        when basic logistic regression fails to converge.
      * 'firth-fallback' requests logistic regression, followed by Firth
        regression whenever the logistic regression fails to converge.  This is
        now the default.
      * 'firth' requests Firth regression all the time.
    * Firth regression can be slow.  To trade off some accuracy for speed, you
      can use the 'firth-residualize' modifier, which implements the shortcut
      described in Mbatchou J et al. (2020) Computationally efficient whole
      genome regression for quantitative and binary traits.  (You can also use
      'cc-residualize' to force this shortcut to be applied to basic logistic
      regression as well.)
      * This must be used with 'hide-covar', and disables some other --glm
        features.
    * To add covariates which are not constant across all variants, add the
      'local-covar=' and 'local-psam=' modifiers, use full filenames for each,
      and use either 'local-pvar=' or 'local-pos-cols=' to provide variant ID
      or position information.
      Normally, the local-covar file should have c * n real-valued columns,
      where the first c columns correspond to the first sample in the
      local-psam file, columns (c+1) to 2c correspond to the second sample,
      etc.; and the mth line corresponds to the mth nonheader line of the
      local-pvar file when there is one.  (Variants outside of the local-pvar
      file are excluded from the regression.)  The local covariates are
      assigned the names LOCAL1, LOCAL2, etc.; to exclude the last local
      covariate from the regression (necessary if they are e.g. local ancestry
      coefficients which sum to 1), add 'local-omit-last'.
      Alternatively, with 'local-cats='<k>, the local-covar file is expected to
      have n columns with integer-valued entries in [1, k].  (This range is
      [0, k-1] with 'local-cats0='.)  These category assignments are expanded
      into (k-1) local covariates in the usual manner.
      When position information is in the local-covar file, this should be
      indicated by 'local-pos-cols='<number of header rows>,<chrom col #>,<pos
      start col #>,<first covariate col #>.
      'local-haps' indicates that there's one column or column-group per
      haplotype instead of per sample; they are averaged by --glm.
    The main report supports the following column sets:
      chrom: Chromosome ID.
      pos: Base-pair coordinate.
      (ID is always present, and positioned here.)
      ref: Reference allele.
      alt1: Alternate allele 1.
      alt: All alternate alleles, comma-separated.
      (A1 is always present, and positioned here.  For multiallelic variants,
      this column may contain multiple comma-separated alleles when the result
      doesn't depend on which allele is A1.)
      ax: Non-A1 alleles, comma-separated.
      a1count: A1 allele count (can be decimal with dosage data).
      totallele: Allele observation count (can be higher than --freq value, due
                 to inclusion of het haploids and chrX model).
      a1countcc: A1 count in cases, then controls (case/control only).
      totallelecc: Case and control allele observation counts.
      gcountcc: Genotype hardcall counts (neither-A1, het-A1, A1-A1) in cases,
                then controls (case/control only).
      a1freq: A1 allele frequency.
      a1freqcc: A1 frequency in cases, then controls (case/control only).
      machr2: Unphased MaCH imputation quality (frequently labeled 'INFO').
      firth: Reports whether Firth regression was used (firth-fallback only).
      test: Test identifier.  (Required unless only one test is run.)
      nobs: Number of samples in the regression.
      beta: Regression coefficient (for A1 if additive test).
      orbeta: Odds ratio for case/control, beta for quantitative traits.
              (Ignored if 'beta' column set included.)
      se: Standard error of beta.
      ci: Bounds of symmetric approximate confidence interval (requires --ci).
      tz: T-statistic for linear regression, Wald Z-score for logistic/Firth.
      p: Asymptotic p-value (or -log10(p)) for T/Z-statistic.
      err: Error code for NA results.
    The default is chrom,pos,ref,alt,firth,test,nobs,orbeta,se,ci,tz,p,err.

  --score <filename> [i] [j] [k] [{header | header-read}]
          [{center | variance-standardize | dominant | recessive}]
          ['no-mean-imputation'] ['se'] ['zs'] ['ignore-dup-ids']
          [{list-variants | list-variants-zs}] ['cols='<col set descriptor>]
    Apply linear scoring system(s) to each sample.
    The input file should have one line per scored (variant, allele) pair.
    Variant IDs are read from column #i and allele codes are read from column
    #j, where i defaults to 1 and j defaults to i+1.
    * By default, a single column of input coefficients is read from column #k,
      where k defaults to j+1.  (--score-col-nums can be used to specify
      multiple columns.)
    * 'header-read' causes the first line of the input file to be treated as a
      header line containing score names.  Otherwise, score(s) are assigned the
      names 'SCORE1', 'SCORE2', etc.; and 'header' just causes the first line
      to be entirely ignored.
    * By default, copies of unnamed alleles contribute zero to score, while
      missing genotypes contribute an amount proportional to the loaded (via
      --read-freq) or imputed allele frequency.  To throw out missing
      observations instead (decreasing the denominator in the final average
      when this happens), use the 'no-mean-imputation' modifier.
    * You can use the 'center' modifier to shift all genotypes to mean zero, or
      'variance-standardize' to linearly transform the genotypes to mean-0,
      variance-1.
    * The 'dominant' modifier causes dosages greater than 1 to be treated as 1,
      while 'recessive' uses max(dosage - 1, 0) on diploid chromosomes.
      ('dominant', 'recessive', and 'variance-standardize' cannot be used with
      chrX.)
    * The 'se' modifier causes the input coefficients to be treated as
      independent standard errors; in this case, standard errors for the score
      average/sum are reported, under a Gaussian approximation.  (Note that
      this will systematically underestimate standard errors when scored
      variants are in LD.)
    * By default, --score errors out if a variant ID in the input file appears
      multiple times in the main dataset.  Use the 'ignore-dup-ids' modifier to
      skip them instead (a warning is still printed if such variants are
      present).
    * The 'list-variants[-zs]' modifier causes variant IDs used for scoring to
      be written to <output prefix>.sscore.vars[.zst].
    The main report supports the following column sets:
      maybefid: FID, if that column was in the input.
      fid: Force FID column to be written even when absent in the input.
      (IID is always present, and positioned here.)
      maybesid: SID, if that column was in the input.
      sid: Force SID column to be written even when absent in the input.
      pheno1: First active phenotype.
      phenos: All active phenotypes, if any.
      nallele: Number of nonmissing alleles.
      denom: Denominator of score average (equal to nallele value when
             'no-mean-imputation' specified).
      dosagesum: Sum of named allele dosages.
      scoreavgs: Score averages.
      scoresums: Score sums.
    The default is maybefid,maybesid,phenos,nallele,dosagesum,scoreavgs.
    For more sophisticated polygenic risk scoring, we recommend looking at the
    LDpred2 (https://privefl.github.io/bigsnpr/articles/LDpred2.html ) and
    PRSice-2 (https://www.prsice.info/ ) software packages.

  --variant-score <filename> ['bin' | 'bin4' | 'cols='<col set descriptor>]
                  ['zs'] ['single-prec']
    (alias: --vscore)
    Apply linear scoring system(s) to each variant.  Each reported variant
    score is the dot product of a sample-weight vector with the
    total-ALT-dosage vector, with MAF-based mean imputation applied to missing
    dosages.
    Input file format: one line per sample, each starting with an ID and
    followed by scoring weight(s); it can also have a header line with the
    sample ID representation and the score name(s).
    The usual .vscore text report supports the following column sets:
      chrom: Chromosome ID.
      pos: Base-pair coordinate.
      (ID is always present, and positioned here.)
      ref: Reference allele.
      alt1: Alternate allele 1.
      alt: All alternate alleles, comma-separated.
      altfreq: ALT allele frequency used for mean-imputation.
      nmiss: Number of missing (and thus mean-imputed) dosages.
      nobs: Number of (nonmissing) sample observations.
      (Variant scores are always present, and positioned here.)
    Default is chrom,pos,ref,alt.
    If binary output is requested instead, the main .vscore.bin matrix contains
    floating-point values, column (score) ID(s) are saved to
    <output prefix>.vscore.cols, and variant IDs are saved to
    <output prefix>.vscore.vars[.zst].
    'single-prec' causes the computation to use single- instead of
    double-precision floating-point values internally.

  --adjust-file <filename> ['zs'] ['gc'] ['cols='<column set descriptor>]
                ['log10'] ['input-log10'] ['test='<test name, case-sensitive>]
    Given a file with unfiltered association test results, report some basic
    multiple-testing corrections, sorted in increasing-p-value order.
    * 'gc' causes genomic-controlled p-values to be used in the formulas.
      (This tends to be overly conservative.  We note that LD Score regression
      usually does a better job of calibrating lambda; see Lee JJ, McGue M,
      Iacono WG, Chow CC (2018) The accuracy of LD Score regression as an
      estimator of confounding and genetic correlations in genome-wide
      association studies.)
    * 'log10' causes negative base 10 logs of p-values to be reported, instead
      of raw p-values.  'input-log10' specifies that the input file contains
      -log10(p) values.
    * If the input file contains multiple tests per variant which are
      distinguished by a 'TEST' column (true for --linear/--logistic/--glm),
      you must use 'test=' to select the test to process.
    The following column sets are supported:
      chrom: Chromosome ID.
      pos: Base-pair coordinate.
      (ID is always present, and positioned here.)
      ref: Reference allele.
      alt1: Alternate allele 1.
      alt: All alternate alleles, comma-separated.
      a1: Tested allele.  (Omitted if missing from input file.)
      unadj: Unadjusted p-value.
      gc: Devlin & Roeder (1999) genomic control corrected p-value (additive
          models only).
      qq: P-value quantile.
      bonf: Bonferroni correction.
      holm: Holm-Bonferroni (1979) adjusted p-value.
      sidakss: Sidak single-step adjusted p-value.
      sidaksd: Sidak step-down adjusted p-value.
      fdrbh: Benjamini & Hochberg (1995) step-up false discovery control.
      fdrby: Benjamini & Yekutieli (2001) step-up false discovery control.
    Default set is chrom,a1,unadj,gc,bonf,holm,sidakss,sidaksd,fdrbh,fdrby.
  --genotyping-rate ['dosage']
    Report genotyping rate in log (this was automatic in PLINK 1.x).

  --pgen-info
    Reports basic information about a .pgen file.

  --validate
    Validates all variant records in a .pgen file.

  --zst-decompress <.zst file> [output filename]
    (alias: --zd)
    Decompress a Zstd-compressed file.  If no output filename is specified, the
    file is decompressed to standard output.
    This cannot be used with any other flags, and does not cause a log file to
    be generated.

The following other flags are supported.
  --script <fname>    : Include command-line options from file.
  --rerun [log]       : Rerun commands in log (default 'plink2.log').
  --version           : Display only version number before exiting.
  --silent            : Suppress regular output to console.  (Error-output is
                        not suppressed.)
  --double-id         : When importing single-part sample IDs, set both FID and
                        IID to the original ID.
  --const-fid [ID]    : When importing single-part sample IDs, set FID to the
                        given constant and IID to the original ID.
  --id-delim [d]      : Normally parses single-delimiter sample IDs as
                        <FID><d><IID>, and double-delimiter IDs as
                        <FID><d><IID><d><SID>; default delimiter is '_'.
                        --id-delim can no longer be used with
                        --double-id/--const-fid; it will error out if any ID
                        lacks the delimiter.
  --idspace-to <c>    : Convert spaces in VCF/.bgen sample IDs to the given
                        character.
  --iid-sid           : Make --id-delim and --sample-diff interpret two-token
                        sample IDs as IID-SID instead of FID-IID.
  --vcf-require-gt    : Skip variants with no GT field.
  --vcf-min-gq <val>  : No-call genotypes when GQ is present and below the
                        threshold.
  --vcf-max-dp <val>  : No-call genotypes when DP is present and above/below
  --vcf-min-dp <val>    the threshold.
  --vcf-half-call <m> : Specify how '0/.' and similar VCF GT values should be
                        handled.  The following four modes are supported:
                        * 'error'/'e' (default) errors out and reports line #.
                        * 'haploid'/'h' treats them as haploid calls.
                        * 'missing'/'m' treats them as missing.
                        * 'reference'/'r' treats the missing value as 0.
  --vcf-ref-n-missing : Import VCF 'N' REF alleles as missing alleles.  This
                        can be appropriate for .ped-derived VCFs.
  --oxford-single-chr <chr name>  : Specify single-chromosome .gen/.bgen file
                                    with no useful chromosome info inside.
  --missing-code [string list]    : Comma-delimited list of missing phenotype
    (alias: --missing_code)         values for Oxford-format import (default
                                    'NA').
  --hard-call-threshold <val>     : When importing dosage data, a hardcall is
                                    normally saved when the distance from the
                                    nearest hardcall, defined as
                                      0.5 * sum_i |x_i - round(x_i)|
                                    (where the x_i's are 0..2 allele dosages),
                                    is not greater than 0.1.  You can adjust
                                    this threshold by providing a numeric
                                    argument to --hard-call-threshold.
                                    You can also use this with --make-[b]pgen
                                    to alter the saved hardcalls while leaving
                                    the dosages untouched, or --make-bed to
                                    tweak hardcall export.
  --dosage-erase-threshold <val>  : --hard-call-threshold normally preserves
                                    the original dosages, and several PLINK 2
                                    commands use them when they're available.
                                    Use --dosage-erase-threshold to make PLINK
                                    2 erase dosages and keep only hardcalls
                                    when distance-from-hardcall <= the given
                                    level.
  --import-dosage-certainty <val> : The PLINK 2 file format currently supports
                                    a single dosage for each allele.  Some
                                    other dosage file formats include a
                                    separate probability for every possible
                                    genotype, e.g. {P(0/0)=0.2, P(0/1)=0.52,
                                    P(1/1)=0.28}, a highly uncertain call that
                                    is nevertheless treated as a hardcall under
                                    '--hard-call-threshold 0.1'.  To make PLINK
                                    2 treat a dosage as missing whenever the
                                    largest probability is less than a
                                    threshold, use --import-dosage-certainty.
  --input-missing-genotype <c> : '.' is always interpreted as a missing
                                 genotype code in input files.  By default, '0'
                                 also is; you can change this second missing
                                 code with --input-missing-genotype.
  --allow-extra-chr  : Permit unrecognized chromosome codes (alias --aec).
  --chr-set <autosome ct> ['no-x'] ['no-y'] ['no-xy'] ['no-mt'] :
    Specify a nonhuman chromosome set.  The first parameter sets the number of
    diploid autosome pairs if positive, or haploid chromosomes if negative.
    Given diploid autosomes, the remaining modifiers indicate the absence of
    the named non-autosomal chromosomes.
  --cow/--dog/--horse/--mouse/--rice/--sheep : Shortcuts for those species.
  --autosome-num <val>    : Alias for '--chr-set <value> no-y no-xy no-mt'.
  --human                 : Explicitly specify human chromosome set, and make
                            output .pvar/VCF files include a ##chrSet header
                            line.  (.pvar/VCF output files automatically
                            include ##chrSet when a nonhuman set is specified.)
  --chr-override ['file'] : By default, if --chr-set/--autosome-num/--cow/etc.
                            conflicts with an input file ##chrSet header line,
                            PLINK 2 will error out.  --chr-override with no
                            argument causes the command line to take
                            precedence; '--chr-override file' defers to the
                            file.
  --var-min-qual <val>             : Skip variants with low/missing QUAL.
  --var-filter [exception(s)...]   : Skip variants which have FILTER failures.
  --extract-if-info <key> <op> <val> : Exclude variants which don't/do satisfy
  --exclude-if-info <key> <op> <val>   a comparison predicate on an INFO key,
  (aliases: --extract-if,              e.g.
            --exclude-if)                --extract-if-info "VT == SNP"
                                       Unless the operator is !=, the predicate
                                       always evaluates to false when the key
                                       is missing.
  --require-info <key(s)...>         : Exclude variants based on nonexistence
  --require-no-info <key(s)...>        or existence of an INFO key.  "<key>=."
                                       is treated as nonexistence.
  --extract-col-cond <f> [valcol] [IDcol] [skip] :
  --extract-col-cond-match <(sub)string(s)...>
  --extract-col-cond-mismatch <(sub)string(s)...>
  --extract-col-cond-substr
  --extract-col-cond-min <min>
  --extract-col-cond-max <max> :
    Exclude all variants without a value-column entry satisfying a condition.
    * By default, values are read from column 2 of the file, and variant IDs
      are read from column 1.
    * Three types of conditions are supported:
      * When --extract-col-cond-match is specified without
        --extract-col-cond-substr, the value is checked for equality with the
        given strings, and kept iff one of them matches.  Similarly,
        --extract-col-cond-mismatch without --extract-col-cond-substr causes
        the variant to be kept iff the value matches none of the given strings.
      * When --extract-col-cond-match and/or -mismatch are specified with
        --extract-col-cond-substr, the variant is kept iff none of the
        --extract-col-cond-mismatch substrings are contained in the value, and
        either --extract-col-cond-match was unspecified or at least one of its
        substrings is contained.
      * Otherwise, the value is interpreted as a number, and the variant is
        kept if the number is in [<min>, <max>] (default min=0, max=DBL_MAX).
  --pheno ['iid-only'] <f> : Specify additional phenotype/covariate file.
                             Comma-delimited files with a header line are now
                             permitted.
  --pheno-name <name...>   : Only load the designated phenotype(s) from the
                             --pheno (if one was specified) or .psam (if no
                             --pheno) file.  Separate multiple names with
                             spaces or commas, and use dashes to designate
                             ranges.
  --pheno-col-nums <#...>  : Only load the phenotype(s) in the designated
                             column number(s) from the --pheno file.
  --no-psam-pheno          : Ignore phenotype(s) in .psam/.fam file.
  --strict-sid0      : By default, if there is no SID column in the .psam/.fam
                       (or --update-ids) file, but there is one in another
                       input file (for e.g. --keep/--remove), the latter SID
                       column is ignored; sample IDs are considered matching as
                       long as FID and IID are equal (with missing FID treated
                       as '0').  If you also want to require SID = '0' for a
                       sample ID match in this situation, add --strict-sid0.
  --input-missing-phenotype <v> : Set nonzero number to treat as a missing
                                  pheno/covar in input files (default -9).
  --no-input-missing-phenotype  : Don't treat any nonzero number as a missing
                                  pheno/covar.  ('NA'/'nan' are still treated
                                  as missing.)
  --1                           : Expect case/control phenotypes in input files
                                  to be coded as 0 = control, 1 = case, instead
                                  of the usual 0 = missing, 1 = ctrl, 2 = case.
                                  (Unlike PLINK 1.x, this does not force all
                                  phenotypes to be interpreted as case/ctrl.)
  --missing-catname <str>       : Set missing-categorical-phenotype string
                                  (case-sensitive, default 'NONE').
  --covar ['iid-only'] <f> : Specify additional covariate file.
                             Comma-delimited files with a header line are now
                             permitted.
  --covar-name <name...>   : Only load the designated covariate(s) from the
                             --covar (if one was specified), --pheno (if no
                             --covar), or .psam (if no --covar or --pheno)
                             file.
  --covar-col-nums <#...>  : Only load the covariate(s) in the designated
                             column number(s) from the --covar (if one was
                             specified) or --pheno (if no --covar) file.
  --within <f> [new pheno name] : Import a PLINK 1.x categorical phenotype.
                                  (Phenotype name defaults to 'CATPHENO'.)
                                  * If any numeric values are present, ALL
                                    values must be numeric.  In that case, 'C'
                                    is added in front of all category names.
                                  * 'NA' is treated as a missing value.
  --mwithin <n>                 : Load --within categories from column n+2.
  --family [new pheno name]     : Create a categorical phenotype from FID.
                                  Restrictions on and handling of numeric
                                  values are the same as for --within.
  --family-missing-catname <nm> : Make --family treat the specified FID as
                                  missing.
  --keep <fname...>    : Exclude all samples not named in a file.
  --remove <fname...>  : Exclude all samples named in a file.
  --keep-fam <fn...>   : Exclude all families not named in a file.
  --remove-fam <f...>  : Exclude all families named in a file.
  --extract [{bed0 | bed1}] <f...> : Usually excludes all variants (not) named
  --exclude [{bed0 | bed1}] <f...>   in the given file(s).  When multiple files
                                     are named, they are concatenated.
                                     With the 'bed0' or 'bed1' modifier,
                                     variants outside/inside the positional
                                     ranges in the interval-BED file(s) are
                                     excluded instead.  'bed0' tells PLINK 2 to
                                     assume the interval bounds follow the UCSC
                                     0-based half-open convention, while 'bed1'
                                     (equivalent to PLINK 1.9 'range')
                                     specifies 1-based fully-closed.
  --extract-intersect [{bed0 | bed1}] <f...> : Just like --extract, except that
                                               a variant must be in the
                                               intersection, rather than just
                                               the union, of the files to
                                               remain.
  --bed-border-bp <n>      : Stretch BED intervals by the given amount on each
  --bed-border-kb <n>        side.
  --keep-cats <filename>   : These can be used individually or in combination
  --keep-cat-names <nm...>   to define a list of categories to keep; all
                             samples not in one of the named categories are
                             excluded.  Use spaces to separate category names
                             for --keep-cat-names.  Use the --missing-catname
                             value (default 'NONE') to refer to the group of
                             uncategorized samples.
  --keep-cat-pheno <pheno> : If more than one categorical phenotype is loaded,
                             or you wish to filter on a categorical covariate,
                             --keep-cat-pheno must be used to specify which
                             phenotype/covariate --keep-cats and
                             --keep-cat-names apply to.
  --remove-cats <filename> : Exclude all categories named in the file.
  --remove-cat-names <...> : Exclude named categories.
  --remove-cat-pheno <phe> : Specify pheno for --remove-cats/remove-cat-names.
  --split-cat-pheno [{omit-most | omit-last}] ['covar-01']
                    [cat. pheno/covar name(s)...] :
    Split n-category phenotype(s) into n (or n-1, with 'omit-most'/'omit-last')
    binary phenotypes, with names of the form <orig. pheno name>=<cat. name>.
    (As a consequence, affected phenotypes and categories are not permitted to
    contain the '=' character.)
    * This happens after all sample filters.
    * If no phenotype or covariate names are provided, all categorical
      phenotypes (but not covariates) are processed.
    * By default, generated covariates are coded as 1=false, 2=true.  To code
      them as 0=false, 1=true instead, add the 'covar-01' modifier.
  --loop-cats <pheno/covar>   : Run variant filters and subsequent operations
                                on just the samples in the first category; then
                                just the samples in the second category; and so
                                on, for all categories in the named categorical
                                phenotype.
  --no-id-header ['iid-only'] : Don't include a header line in .id output
                                files.  This normally forces two-column FID/IID
                                output; add 'iid-only' to force just
                                single-column IID.
  --variance-standardize [pheno/covar name(s)...]
  --covar-variance-standardize [covar name(s)...] :
    Linearly transform named covariates (and quantitative phenotypes, if
    --variance-standardize) to mean-zero, variance 1.  If no arguments are
    provided, all possible phenotypes/covariates are affected.
    This is frequently necessary to prevent the multicollinearity check from
    failing when dealing with covariates where abs(mean) is much larger than
    the standard deviation, such as year of birth.
  --quantile-normalize [...]       : Force named covariates and quantitative
  --pheno-quantile-normalize [...]   phenotypes to a N(0,1) distribution,
  --covar-quantile-normalize [...]   preserving only the original rank orders.
  --chr <chr(s)...>  : Exclude all variants not on the given chromosome(s).
                       Valid choices for humans are 0 (unplaced), 1-22, X, Y,
                       XY, MT, PAR1, and PAR2.  Separate multiple chromosomes
                       with spaces and/or commas, and use a dash (no adjacent
                       spaces permitted) to denote a range, e.g.
                       '--chr 1-4, 22, par1, x, par2'.
  --not-chr <...>    : Reverse of --chr (exclude variants on listed
                       chromosomes).
  --autosome         : Exclude all non-autosomal variants.
  --autosome-par     : Exclude all non-autosomal variants, except those in a
                       pseudo-autosomal region.
  --snps-only ['just-acgt'] : Exclude non-SNP variants.  By default, SNP = all
                              allele codes are single-character (so
                              multiallelic variants with a mix of SNPs and
                              non-SNPs are excluded; split your variants first
                              if that's a problem).
                              The 'just-acgt' modifier restricts SNP codes to
                              {A,C,G,T,a,c,g,t,<missing>}.
  --from <var ID>    : Use ID(s) to specify a variant range to load.  When used
  --to   <var ID>      together, both variants must be on the same chromosome.
                       (--snps can be used to specify intervals which cross
                       chromosome boundaries.)
  --snp  <var ID>    : Specify a single variant to load.
  --exclude-snp <ID> : Specify a single variant to exclude.
  --window  <kbs>    : With --snp/--exclude-snp, loads/excludes all variants
                       within half the specified kb distance of the named one.
  --from-bp <pos>    : Use base-pair coordinates to define a variant range to
  --to-bp   <pos>      load.
  --from-kb <pos>      * You must use these with --chr, specifying a single
  --to-kb   <pos>        chromosome.
  --from-mb <pos>      * Decimals and negative numbers are permitted.
  --to-mb   <pos>      * The --to-bp(/-kb/-mb) position is no longer permitted
                         to be smaller than the --from-bp position.
  --snps <var IDs...>  : Use IDs to specify variant range(s) to load or
  --exclude-snps <...>   exclude.  E.g. '--snps rs1111-rs2222, rs3333, rs4444'.
  --force-intersect    : PLINK 2 normally errors out when multiple variant
                         inclusion filters (--extract, --extract-col-cond,
                         --extract-intersect, --from/--to, --from-bp/--to-bp,
                         --snp, --snps) are specified.  --force-intersect
                         allows the run to proceed; the set intersection will
                         be taken.
  --thin <p>           : Randomly remove variants, retaining each with prob. p.
  --thin-count <n>     : Randomly remove variants until n of them remain.
  --bp-space <bps>     : Remove variants so that each pair is no closer than
                         the given bp distance.
  --thin-indiv <p>       : Randomly remove samples, retaining with prob. p.
  --thin-indiv-count <n> : Randomly remove samples until n of them remain.
  --keep-col-match <f> <val(s)...> : Exclude all samples without a 3rd column
                                     entry in the given file exactly matching
                                     one of the given strings.  (Separate
                                     multiple strings with spaces.)
  --keep-col-match-name <col name> : Check column with given name instead.
  --keep-col-match-num <n>         : Check nth column instead.
  --geno [val] [{dosage | hh-missing}]
  --mind [val] [{dosage | hh-missing}] :
    Exclude variants (--geno) and/or samples (--mind) with missing call
    frequencies greater than a threshold (default 0.1).  (Note that the default
    threshold is only applied if --geno/--mind is invoked without an argument;
    when --geno/--mind is not invoked, no missing call frequency ceiling is
    enforced at all.  Other inclusion/exclusion default thresholds work the
    same way.)
    By default, when a dosage is present but a hardcall is not, the genotype is
    treated as missing; add the 'dosage' modifier to treat this case as
    nonmissing.  Alternatively, you can use 'hh-missing' to also treat
    heterozygous haploid calls as missing.
  --require-pheno [name(s)...] : Remove samples missing any of the named
  --require-covar [name(s)...]   phenotype(s)/covariate(s).  If no arguments
                                 are provided, all phenotype(s)/covariate(s)
                                 must be present.
  --maf [freq] [mode]     : Exclude variants with allele frequency lower than a
    (alias: --min-af)       threshold (default 0.01).  By default, the nonmajor
                            allele frequency is used; the other supported modes
                            are 'nref' (non-reference), 'alt1', and 'minor'
                            (least frequent).  bcftools freq:mode notation is
                            permitted.
  --max-maf <freq> [mode] : Exclude variants with MAF greater than the
    (alias: --max-af)       threshold.
  --mac <ct> [mode]       : Exclude variants with allele dosage lower than the
    (alias: --min-ac)       given threshold.
  --max-mac <ct> [mode]   : Exclude variants with allele dosage greater than
    (alias: --max-ac)       the given threshold.
  --af-pseudocount <x>    : Given j observations of one allele and k
                            observations of the other for a biallelic variant,
                            infer allele frequencies of (j+x) / (j+k+2x) and
                            (k+x) / (j+k+2x), rather than the default j / (j+k)
                            and k / (j+k).
                            * For multiallelic variants, note that this makes
                              unobserved ALT alleles matter.
                            * This does not affect --freq's output.
  --min-alleles <ct> : Exclude variants with fewer than the given # of alleles.
                       (When a variant has exactly one ALT allele, and it's
                       a missing-code, it's excluded by "--min-alleles 2".)
  --max-alleles <ct> : Exclude variants with more than the given # of alleles.
  --read-freq <file> : Load allele frequency estimates from the given --freq or
                       --geno-counts (or PLINK 1.9 --freqx) report, instead of
                       imputing them from the immediate dataset.
  --hwe <p> ['midp'] ['keep-fewhet'] :
    Exclude variants with Hardy-Weinberg equilibrium exact test p-values below
    a threshold.
    * By default, only founders are considered.
    * chrX p-values are now computed using Graffelman and Weir's method.
    * For variants with k alleles with k>2, k separate 'biallelic' tests are
      performed, and the variant is filtered out if any of them fail.
    * With 'keep-fewhet', variants which fail the test in the too-few-hets
      direction are not excluded.  On chrX, this uses the ratio between the
      Graffelman/Weir p-value and the female-only p-value.
    * There is currently no special handling of case/control phenotypes.
  --mach-r2-filter [min] [max] : Exclude variants with MaCH imputation quality
                                 metric less than min or greater than max
                                 (defaults 0.1 and 2.0).  (Monomorphic
                                 variants, with r2 = nan, are not excluded.)
                                 * This is NOT identical to the R2 metric
                                   reported by Minimac3 0.1.13+; see below.
                                 * If a single argument is provided, it is
                                   treated as the minimum.
                                 * The metric is not computed on chrX and MT.
  --minimac3-r2-filter <min> [max] : Compute Minimac3 R2 values from scratch,
                                     and exclude variants with R2 less than min
                                     or (if max is provided) greater than max.
                                     * Note that this requires phased-dosage
                                       data for all samples and variants;
                                       otherwise this will systematically
                                       underestimate imputation quality, since
                                       unphased hardcalls/dosages are treated
                                       as if they were maximally uncertain.
                                       (Use --extract-if-info/--exclude-if-info
                                       to filter on precomputed Minimac3 R2 in
                                       a VCF/.pvar INFO column.)
  --keep-females     : Exclude male and unknown-sex samples.
  --keep-males       : Exclude female and unknown-sex samples.
  --keep-nosex       : Exclude all known-sex samples.
  --remove-females   : Exclude female samples.
  --remove-males     : Exclude male samples.
  --remove-nosex     : Exclude unknown-sex samples.
  --keep-founders    : Exclude nonfounder samples.
  --keep-nonfounders : Exclude founder samples.
  --keep-if <pheno/covar> <op> <val> : Exclude samples which don't/do satisfy a
  --remove-if <pheno/covar> <op> <v>   comparison predicate, e.g.
                                         --keep-if "PHENO1 == case"
                                       Unless the operator is !=, the predicate
                                       always evaluates to false when the
                                       phenotype/covariate is missing.
  --nonfounders      : Include nonfounders in allele freq/HWE calculations.
  --bad-freqs        : When PLINK 2 needs decent allele frequencies, it
                       normally errors out if they aren't provided by
                       --read-freq and less than 50 founders are available to
                       impute them from.  Use --bad-freqs to force PLINK 2 to
                       proceed in this case.
  --bad-ld           : PLINK 2 normally errors out when it needs to estimate LD
                       between variants, but there are less than 50 founders to
                       estimate from.  Use --bad-ld to force PLINK 2 to
                       proceed.
  --export-allele <file> : With --export A/A-transpose/AD, count alleles named
                           in the file, instead of REF alleles.
  --output-chr <MT code> : Set chromosome coding scheme in output files by
                           providing the desired human mitochondrial code.
                           Options are '26', 'M', 'MT', '0M', 'chr26', 'chrM',
                           and 'chrMT'; default is now 'MT' (note that this is
                           a change from PLINK 1.x, which defaulted to '26').
  --output-missing-genotype <ch> : Set the code used to represent missing
                                   genotypes in PLINK-format files generated by
                                   --make-[b]pgen/--make-bed/--export (default
                                   '.').
  --output-missing-phenotype <s> : Set the string used to represent missing
                                   phenotypes in PLINK-format files generated
                                   by --make-[b]pgen/--make-bed/--export
                                   (default 'NA' for .psam, -9 for older).
  --sort-vars [mode]      : Sort variants by chromosome, then position, then
                            ID.  The following string orders are supported:
                            * 'natural'/'n': Natural sort (default).
                            * 'ascii'/'a': ASCII.
                            This must be used with --pmerge[-list] or
                            --make-[b]pgen/--make-bed.
  --set-hh-missing ['keep-dosage'] : Make --make-[b]pgen/--make-bed set non-MT
                                     heterozygous haploid hardcalls, and all
                                     female chrY calls, to missing.  (Unlike
                                     PLINK 1.x, this treats unknown-sex chrY
                                     genotypes like males, not females.)
                                     By default, all associated dosages are
                                     also erased; use 'keep-dosage' to keep
                                     them all.
  --set-mixed-mt-missing ['keep-dosage'] : Make --make-[b]pgen/--make-bed set
                                           mixed MT hardcalls to missing.
  --split-par <bp1> <bp2> : Changes chromosome code of all X chromosome
  --split-par <build>       variants with bp position <= bp1 to PAR1, and those
                            with position >= bp2 to PAR2.  The following build
                            codes are supported as shorthand:
                            * 'b36'/'hg18' = NCBI 36, 2709521/154584237
                            * 'b37'/'hg19' = GRCh37, 2699520/154931044
                            * 'b38'/'hg38' = GRCh38, 2781479/155701383
  --merge-par             : Merge PAR1/PAR2 back with X.  Requires PAR1 to be
                            positioned immediately before X, and PAR2 to be
                            immediately after X.  (Should *not* be used with
                            "--export vcf", since it causes male
                            homozygous/missing calls in PAR1/PAR2 to be
                            reported as haploid.)
  --merge-x               : Merge XY back with X.  This usually has to be
                            combined with --sort-vars.
  --set-missing-var-ids <t>  : Given a template string with a '@' where the
  --set-all-var-ids <t>        chromosome code should go and '#' where the bp
                               coordinate belongs, --set-missing-var-ids
                               assigns chromosome-and-bp-based IDs to unnamed
                               variants, while --set-all-var-ids resets all
                               IDs.
                               You may also use '$r'/'$a' to refer to the
                               ref and alt1 alleles, or '$1'/'$2' to refer to
                               them in alphabetical order.
  --var-id-multi <t>         : Specify alternative templates for multiallelic
  --var-id-multi-nonsnp <t>    variants.  ('$a' and '$1'/'$2' should be avoided
                               here, though they're technically still allowed.)
  --new-id-max-allele-len <len> [{error | missing | truncate}] :
    Specify maximum number of leading characters from allele codes to include
    in new variant IDs, and behavior on longer codes (defaults 23, error).
  --missing-var-code <str>   : Change unnamed variant code for --rm-dup,
                               --set-{missing|all}-var-ids, and
                               --recover-var-ids (default '.').
  --update-map  <f> [bpcol]  [IDcol]  [skip] : Update variant bp positions.
  --update-name <f> [newcol] [oldcol] [skip] : Update variant IDs.
  --recover-var-ids <file> ['strict-bim-order'] [{rigid | force}] ['partial'] :
    Undo --set-all-var-ids, given the original .pvar/VCF/.bim file.  Original
    IDs are looked up by position and allele codes.
    * By default, if the original-ID file is a .bim, allele order is ignored.
      Use 'strict-bim-order' to force A1=ALT, A2=REF.
    * If any variant has multiple matching records in the original-ID file, and
      the IDs conflict, --recover-var-ids writes the affected (current) ID(s)
      to <output prefix>.recoverid.dup, and normally errors out.  If the
      original-ID file has the same number of variants in the same order, you
      can still recover the old IDs with the 'rigid' modifier in this case.
      Alternatively, to proceed and assign the missing-ID code to these
      variants, add the 'force' modifier.  (The .recoverid.dup file is still
      written when 'rigid' or 'force' is specified.)
    * --recover-var-ids normally expects to replace all variant IDs, and errors
      out if any are left untouched.  Add the 'partial' modifier when you
      actually want to update just a proper subset.
  --update-alleles <fname>   : Update variant allele codes.
  --update-ids <fname>       : Update sample IDs.
  --update-parents <fname>   : Update parental IDs.
  --update-sex <filename> ['col-num='<n>] ['male0'] :
    Update sex information.
    * By default, if there is a header line starting with '#FID'/'#IID', sex is
      loaded from the first column titled 'SEX' (any capitalization);
      otherwise, column 3 is assumed.  Use 'col-num=' to force a column number.
    * Only the first character in the sex column is processed.  By default,
      '1'/'M'/'m' is interpreted as male, '2'/'F'/'f' is interpreted as female,
      and '0'/'N'/'U'/'u' is interpreted as unknown-sex.  To change this to
      '0'/'M'/'m' = male, '1'/'F'/'f' = female, anything else other than '2' =
      unknown-sex, add 'male0'.
  --real-ref-alleles  : Treat A2 alleles in a PLINK 1.x fileset as actual REF
                        alleles; otherwise they're marked as provisional.
  --maj-ref ['force'] : Set major alleles to reference, like PLINK 1.x
                        automatically did.  (Note that this is now opt-in
                        rather than opt-out; --keep-allele-order is no longer
                        necessary to prevent allele-swapping.)
                        * This can only be used in runs with
                          --make-bed/--make-[b]pgen/--export and no other
                          commands.
                        * By default, this only affects variants marked as
                          having 'provisional' reference alleles.  Add 'force'
                          to apply this to all variants.
                        * All new reference alleles are marked as provisional.
  --ref-allele ['force'] <filename> [refcol] [IDcol] [skip]
  --alt1-allele ['force'] <filename> [alt1col] [IDcol] [skip] :
    These set the alleles specified in the file to ref (--ref-allele) or alt1
    (--alt1-allele).  They can be combined in the same run.
    * These can only be used in runs with --make-bed/--make-[b]pgen/--export
      and no other commands.
    * "--ref-allele <VCF filename> 4 3 '#'", which scrapes reference allele
      assignments from a VCF file, is especially useful.
    * By default, these error out when asked to change a 'known' reference
      allele.  Add 'force' to permit that (when e.g. switching to a new
      reference genome).
    * When --alt1-allele changes the previous ref allele to alt1, the previous
      alt1 allele is set to reference and marked as provisional.
  --ref-from-fa ['force'] : This sets reference alleles from the --fa file when
                            it can be done unambiguously (note that it's never
                            possible for deletions or some insertions).
                            By default, it errors out when asked to change a
                            'known' reference allele; add the 'force' modifier
                            to permit that.
  --normalize ['list']    : Left-normalize all variants, using the --fa file.
    (alias: --norm)         (Assumes no differences in capitalization.)  The
                            'list' modifier causes a list of affected variant
                            IDs to be written to <output prefix>.normalized.
  --indiv-sort <mode> [f] : Specify sample ID sort order for merge and
                            --make-[b]pgen/--make-bed.  The following four
                            modes are supported:
                            * 'none'/'0' keeps samples in the order they were
                              loaded.  Default for non-merge.
                            * 'natural'/'n' invokes "natural sort", e.g.
                              'id2' < 'ID3' < 'id10'.  Default when merging.
                            * 'ascii'/'a' sorts in ASCII order, e.g.
                              'ID3' < 'id10' < 'id2'.
                            * 'file'/'f' uses the order in the given file
                              (named in the last argument).
  --pmerge-list-dir <dir>  : Specify base dir to join to --pmerge-list entries.
  --pmerge-output-vzs      : Compress the .pvar file from --pmerge[-list].
  --sample-inner-join      : By default, --pmerge[-list] performs an 'outer
  --variant-inner-join       join': the merged fileset contains the union of
  --pheno-inner-join         the samples in the input filesets, and ditto for
                             variants and phenotypes.
                             --{sample,variant,pheno}-inner-join specifies an
                             intersection instead.
  --merge-mode <mode>      : Set --pmerge[-list] conflict resolution mode for
  --merge-parents-mode <m>   genotypes/dosages, parents, sexes, and phenotypes,
  --merge-sex-mode <mode>    respectively.
  --merge-pheno-mode <m>     * 'nm-match'/'1' = nonmissing values must match
                                                (default)
                             * 'nm-first'/'2' = keep first nonmissing value
                             * 'first'/'4' = keep first value, even if missing
  --merge-xheader-mode <m> : Set conflict resolution mode for .pvar header
                             entries.
                             * 'erase' = remove all
                             * 'match' = discard when there's ANY difference in
                                         the values (even capitalization)
                             * 'first' = keep first value (default)
  --merge-qual-mode <mode> : Set conflict resolution mode for
  --merge-filter-mode <m>    QUAL/FILTER/INFO/CM entries.
  --merge-info-mode <mode>   * 'erase' = remove column
  --merge-cm-mode <mode>     * 'nm-match' = nonmissing values must match
                             * 'nm-first' = keep first nonmissing (info/CM
                                            default)
                             * 'first' = keep first value, even if missing
                             * 'min' = keep minimum value (--merge-qual-mode
                                       default, not applicable to others)
                             * 'np-union' = keep all non-PASS values
                                            (--merge-filter-mode default, not
                                            applicable to others)
  --merge-pheno-sort <m>   : Set sort order for phenotype columns and INFO
  --merge-info-sort <mode>   entries when merging.
                             * 'none'/'0' = keep in loaded order (default)
                             * 'ascii'/'a' = ASCII order
                             * 'natural'/'n' = natural sort
  --merge-max-allele-ct <> : Exclude merged variants with more than the
                             specified number of alleles.
  --multiallelics-already-joined : Prevent --pmerge[-list] from erroring out
                                   when a .pvar file appears to have a 'split'
                                   multiallelic variant.
  --king-table-filter <min>      : Specify minimum kinship coefficient for
                                   inclusion in --make-king-table report.
  --king-table-subset <f> [kmin] : Restrict current --make-king-table run to
                                   sample pairs listed in the given .kin0 file.
                                   If a second argument is provided, only
                                   sample pairs with kinship >= that threshold
                                   (in the input .kin0) are processed.
  --condition <variant ID> [{dominant | recessive}] ['multiallelic']
  --condition-list <fname> [{dominant | recessive}] ['multiallelic'] :
    Add the given variant, or all variants in the given file, as --glm
    covariates.
    By default, this errors out if any of the variants are multiallelic; add
    the 'multiallelic' ('m' for short) modifier to allow them.  They'll
    effectively be split against the major allele (unless --glm's 'omit-ref'
    modifier was specified), and all induced covariate names--even for
    biallelic variants--will have an underscore followed by the allele code at
    the end.
  --parameters <...> : Include only the given covariates/interactions in the
                       --glm model, identified by a list of 1-based indices
                       and/or ranges of them.
  --tests <...>      : Perform a (joint) test on the specified term(s) in the
  --tests all          --glm model, identified by 1-based indices and/or ranges
                       of them.
                       * Note that, when --parameters is also present, the
                         indices refer to the terms remaining AFTER pruning by
                         --parameters.
                       * You can use '--tests all' to include all terms.
  --vif <max VIF>    : Set VIF threshold for --glm multicollinearity check
                       (default 50).  (This is no longer skipped for
                       case/control phenotypes.)
  --max-corr <val>   : Skip --glm regression when the absolute value of the
                       correlation between two predictors exceeds this value
                       (default 0.999).
  --xchr-model <m>   : Set the chrX --glm/--condition[-list]/--[v]score model.
                       * '0' = skip chrX.
                       * '1' = add sex as a covar on chrX, code males 0..1.
                       * '2' (default) = chrX sex covar, code males 0..2.
                       (Use the --glm 'interaction' modifier to test for
                       interaction between genotype and sex.)
  --adjust ['zs'] ['gc'] ['log10'] ['cols='<column set descriptor>] :
    For each association test in this run, report some basic multiple-testing
    corrections, sorted in increasing-p-value order.  Modifiers work the same
    way as they do on --adjust-file.
  --lambda                   : Set genomic control lambda for --adjust[-file].
  --adjust-chr-field <n...>  : Set --adjust-file input field names.  When
  --adjust-pos-field <n...>    multiple arguments are given to these flags,
  --adjust-id-field <n...>     earlier names take precedence over later ones.
  --adjust-ref-field <n...>
  --adjust-alt-field <n...>
  --adjust-a1-field <n...>
  --adjust-test-field <n...>
  --adjust-p-field <n...>
  --ci <size>        : Report confidence ratios for odds ratios/betas.
  --pfilter <val>    : Filter out assoc. test results with higher p-values.
  --score-col-nums <...> : Process all the specified coefficient columns in the
                           --score file, identified by 1-based indexes and/or
                           ranges of them.
  --q-score-range <range file> <data file> [i] [j] ['header'] ['min'] :
    Apply --score to subset(s) of variants in the primary score list(s) based
    on e.g. p-value ranges.
    * The first file should have range labels in the first column, p-value
      lower bounds in the second column, and upper bounds in the third column.
      Lines with too few entries, or nonnumeric values in the second or third
      column, are ignored.
    * The second file should contain a variant ID and a p-value on each line
      (except possibly the first).  Variant IDs are read from column #i and
      p-values are read from column #j, where i defaults to 1 and j defaults to
      i+1.  The 'header' modifier causes the first nonempty line of this file
      to be skipped.
    * By default, --q-score-range errors out when a variant ID appears multiple
      times in the data file (and is also present in the main dataset).  To use
      the minimum p-value in this case instead, add the 'min' modifier.
  --vscore-col-nums <...> : Process all the specified coefficient columns in
                            the --variant-score file, identified by 1-based
                            indexes and/or ranges of them.
  --parallel <k> <n> : Divide the output matrix into n pieces, and only compute
                       the kth piece.  The primary output file will have the
                       piece number included in its name, e.g. plink2.king.13
                       or plink2.king.13.zst if k is 13.  Concatenating these
                       files in order will yield the full matrix of interest.
                       (Yes, this can be done before decompression.)
                       N.B. This generally cannot be used to directly write a
                       symmetric square matrix.  Choose square0 or triangle
                       shape instead, and postprocess as necessary.
  --memory <val> ['require'] : Set size, in MiB, of initial workspace malloc
                               attempt.  To error out instead of reducing the
                               request size when the initial attempt fails, add
                               the 'require' modifier.
  --threads <val>    : Set maximum number of compute threads.
  --d <char>         : Change variant/covariate range delimiter (normally '-').
  --seed <val...>    : Set random number seed(s).  Each value must be an
                       integer between 0 and 4294967295 inclusive.
                       Note that --threads and "--memory require" may also be
                       needed to reproduce some randomized runs.
  --native           : Allow Intel MKL to use processor-dependent code paths.
  --output-min-p <p> : Specify minimum p-value to write to reports.  (2.23e-308
                       is useful for preventing underflow in some programs.)
  --debug            : Use slower, more crash-resistant logging method.
  --randmem          : Randomize initial workspace memory (helps catch
                       uninitialized-memory bugs).
  --warning-errcode  : Return a nonzero error code to the OS when a run
                       completes with warning(s).
  --zst-level <lvl>  : Set the Zstd compression level (1-22, default 3).

Primary methods paper:
Chang CC, Chow CC, Tellier LCAM, Vattikuti S, Purcell SM, Lee JJ (2015)
Second-generation PLINK: rising to the challenge of larger and richer datasets.
GigaScience, 4.
```

## References

Chang CC (2021). Data Management and Summary Statistics with PLINK, Chapter 3. 49-65. in Dutheil JY. (Ed) Statistical Population Genomics. Humana Press. [https://link.springer.com/protocol/10.1007/978-1-0716-0199-0_3](https://link.springer.com/protocol/10.1007/978-1-0716-0199-0_3).

Mills, MC, Barban N, Tropf FC (2020). An Introduction to Statistical Genetic Data Analysis. The MIT Press. [https://mitpress.mit.edu/books/introduction-statistical-genetic-data-analysis](https://mitpress.mit.edu/books/introduction-statistical-genetic-data-analysis) ([Code snippets](https://github.com/melindacmills/IntroStatisticalGenetics)).

## Resources

Finemapping tools such as `finemap` and `Susie` require a correlation matrix of variants involved in a region, as shown step-by-step with 1000Genomes data below[^ld],

1. Download the 1000Genomes data, <https://www.cog-genomics.org/plink/2.0/resources>.
2. Build a `reference-file` in which the reference allele for each variant is the first ASCII-sorted allele (via the `--ref-allele force` flag).
3. Create a region-specific reference file: `plink2 --pfile reference-file --extract file_with_variants --make-bed --out reference_region`.
4. Calculate LD for the region,
   - 1.9. `plink --bfile reference_region --r square keep-allele-order`.
   - 2.0. `plink2 --bfile reference_region --r-unphased square ref-based` (e.g., `module load ceuadmin/plink/2.0_20240105; plink2dev --help --r-unphased`).

[^ld]: **Acknowledgement**

    This is courtesy of communications between Nick Schreib and Christopher Chang from the Google group discussion, <https://groups.google.com/u/1/g/plink2-users/c/rhCqeStPKgw>.

    ```bash
    # copy the data so we dont modify the original
    cp /rds/project/jmmh2/rds-jmmh2-projects/olink_proteomics/scallop/INF/INTERVAL/cardio/INTERVAL.* .

    mkdir tmp

    plink2 --bfile INTERVAL --mac 2 --make-pgen multiallelics=- varid-split --chr 1-22 --new-id-max-allele-len 100 missing --out tmp/INTERVAL --set-all-var-ids @_#_\$1_\$2

    # some snps have missing ID, we want to remove them
    plink2 --pfile tmp/INTERVAL --set-missing-var-ids @_#_remove --make-pgen --out tmp/INTERVAL

    # exclude all variants with missing ID, i.e. the ones that are super long.
    awk '!/^#/ && $3 ~ /remove/ {print $3}' tmp/INTERVAL.pvar > tmp/missing_ids.txt
    plink2 --pfile tmp/INTERVAL --exclude tmp/missing_ids.txt --make-pgen --out tmp/INTERVAL --rm-dup exclude-mismatch

    # currently, we have only set the new IDs in the pvar file. We also want to update them in the pgen file, so that A1 in the variant ID matches the actual A1.
    # for this we have to exctract the A1 allel.
    awk '!/^#/{split($3, arr, "_"); print $3, arr[3], arr[4] > "tmp/update_ref_allele.txt"}' tmp/INTERVAL.pvar

    # update the pgen file (and pvar)
    plink2 --pfile tmp/INTERVAL --ref-allele force tmp/update_ref_allele.txt 2 1 --make-pgen --out tmp/INTERVAL_new_ref

    # PwCoCo need bfile format...
    plink2 --pfile tmp/INTERVAL_new_ref --make-bed --out tmp/INTERVAL_new_ref
    ```
