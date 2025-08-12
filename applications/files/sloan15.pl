#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(min max);

my $usage = 

"\nUSAGE: $0 HGDP_file mtHaplogroupFile haplogroupsToExclude > outputFile

HGDP SNP genotype file can be obtained from: http://www.hagsc.org/hgdp/files.html

mtHaplogroupFile should be a tab-delimited text file with each row containing a sample ID (e.g. HGDP00982) and a mitochondrial haplogroup (e.g., L0). 

haplogroupsToExclude is optional and should be provided as a space-delimited list on the command line (e.g., L5 N L1)

outputFile is the destination file for printing standard output

The script requires R (Rscript) to be installed and in your path for performing Fisher's exact tests\n\n";

my $hdgp_file = shift or die ($usage);
my $haplogroup_file = shift or die ($usage);
my %excludedHaplogroups;
while (my $hg = shift){
	$excludedHaplogroups{$hg} = 1;
}

#store haplogroups as a hash: individual ID as key and haplogroup as value
my @haplogroup_lines = file_to_array ($haplogroup_file);
my %haplogroup_hash;
foreach (@haplogroup_lines){
	my $line;
	if ($_ =~ /^([\w\t]+)\s+$/){
		$line = $1;
	}else{
		die ("\nERROR: Could not process line from $haplogroup_file\n$_\n");
	}
	my @sl = split (/\t/, $line);
	$haplogroup_hash{$sl[0]} = $sl[1];
}

my $FH = open_file ($hdgp_file);

#parse header line from HGDP SNP file. Verify that each individiual has an assigned haplogroup and generate an array of haplogroup assignments for individuals in the order in which they appear in the dataset
my $headerLine = <$FH>;
my $chompLine;
if ($headerLine =~ /^([\w\t]+)\s+$/){
	$chompLine = $1;
}else{
	die ("\nERROR: Could not process header line from $hdgp_file\n\n");
}
my @scl = split (/\t/, $chompLine);
shift @scl;
my @haplogroups;
foreach (@scl){
	exists ($haplogroup_hash{$_}) or die ("\nERROR: Cannot find mt haplogroup for $_\n\n");
	push (@haplogroups, $haplogroup_hash{$_});
}

#print header line of output
print "Locus\tN\tBothLociCalled\tNucCall\tMitoCall\tNucGen1\tNucGen2\tNucGen3\tNucGen1Count\tNucGen2Count\tNucGen3Count\tNucAllele1Count\tNucAllele2Count\tNucAllele1Sample\tNucAllele2Sample\tD\'\tDhap\tr2\tr2hap\tD\*\tchisq_df\tchisq\'\tp-value\n";

#print temporary R script file that will be used to run fisher's exact test to test for significant LD
my $FH_RSCRIPT = open_output ("TEMP_R_SCRIPT");
print $FH_RSCRIPT 'tf = read.csv("TEMP_R_MATRIX")', "\n", 'fisher.test(as.matrix(tf[,2:dim(tf)[2]]), simulate.p.value=TRUE, B=100000)', "\n";

#Keep track of SNP count to monitor progress
my $snpCount = 0;

#loop through each line (locus) of SNP data in the HGDP data file
while (<$FH>){

	#report progress
	++$snpCount;
	unless ($snpCount % 1000){
		my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
		if ($sec < 10){
			$sec = "0".$sec;
		}
		if ($min < 10){
			$min = "0".$min;
		}
		if ($hour < 10){
			$hour = "0".$hour;
		}

		print STDERR "$hour\:$min\:$sec\t$snpCount SNPs\n";
	}
	
	my $line;
	#remove end character (white space) from each line
	if ($_ =~ /^([\w\t\-]+)\s+$/){
		$line = $1;
	}else{
		die ("\nERROR: Could not process end character from line in $haplogroup_file\n\n");
	}
	#store SNPs in an array
	my @sl = split (/\t/, $line);
	my $snp_id = shift (@sl);
	
	#call subroutine to calculate LD stats based on SNP data and mt haplogroup data
	my $ld_string = cytonuclear_ld (\@sl, \@haplogroups);
	
	#print output line for the locus
	print "$snp_id\t$ld_string\n";
}

#Delete temporary files
-e "TEMP_R_SCRIPT" and unlink ("TEMP_R_SCRIPT");
-e "TEMP_R_OUT" and unlink ("TEMP_R_OUT");
-e "TEMP_R_MATRIX" and unlink ("TEMP_R_MATRIX");

#given an array of nuclear genotypes and an array of mito genotypes (references) return the following:
#num of genotypes; call rate for nuc, mito and both; allele and genotype freqs for nuclear locus; various measures of cytonuclear LD according to Zhao et al. 2005. The subroutine also calls R to perform a Fisher's exact test for to identify significantly non-random associations between nuclear alleles and mitochondrial haplotypes.
sub cytonuclear_ld {
	
	use strict;
	use warnings;
	
	my ($nucRef, $mitoRef) = @_;
	
	my @nuc = @$nucRef;
	my @mito = @$mitoRef;
	
	scalar @nuc == scalar @mito or die ("\nERROR: array lengths for nuclear and mitochondrial genotypes must match\n\n");
	
	my $sampleSize = scalar @nuc;
	my $mitoCall = 0;
	my $nucCall = 0;
	my $bothCall = 0;
	
	my %nucGenotypeHash_raw;
	my %nucGenotypeHash;
	my %nucAlleleHash_rand;
	my %mitoAlleleHash;
	my %nucMitoHash;
	
	my $correctedSampleSize = $sampleSize;
	
	#loop through each individual in the dataset
	for (my $i = 0; $i < $sampleSize; ++$i){
		#remove individuals that belong to excluded haplogroups	
		if(exists $excludedHaplogroups{$mito[$i]}){
			--$correctedSampleSize;
			next;
		#only proceed with individuals that have genotype calls for mito haplogroup and this nuclear locus
		}elsif ($nuc[$i] ne '--'){
			if ($mito[$i] ne '-'){
				++$mitoCall;
				++$nucCall;
				++$bothCall;
			}else{
				++$nucCall;
				next;
			}
		}elsif ($mito[$i] ne '-'){
			++$mitoCall;
			next;
		}else{
			next;
		}
		
		#count up geneotypes
		++$nucGenotypeHash_raw{$nuc[$i]};
		++$mitoAlleleHash{$mito[$i]};
		#randomly sample one allele from diploid nuclear genotypes and store counts of mitonuclear genotypes
		if (rand() < 0.5){
			++$nucAlleleHash_rand{substr($nuc[$i], 0, 1)};
			++$nucMitoHash{substr($nuc[$i], 0, 1) . '_' . $mito[$i]}
		}else{
			++$nucAlleleHash_rand{substr($nuc[$i], 1, 1)};
			++$nucMitoHash{substr($nuc[$i], 1, 1) . '_' . $mito[$i]}
		}
	}

	my $returnString = "$correctedSampleSize\t$bothCall\t$nucCall\t$mitoCall";
	
	#re-order nuclear genotypes so that they can be processed by sorting (e.g., AA, AC, CC)
	foreach my $dinuc (keys %nucGenotypeHash_raw){
		if ((substr ($dinuc, 0, 1) cmp substr ($dinuc, 1, 1)) == 1){
			$nucGenotypeHash{substr ($dinuc, 1, 1).substr ($dinuc, 0, 1)} = $nucGenotypeHash_raw{$dinuc};
		}else{
			$nucGenotypeHash{$dinuc} = $nucGenotypeHash_raw{$dinuc};
		}
	}

	my $genotypes;
	my $genotypeCounts;
	
	#if all three possible nuclear genotypes are found, calculate allele counts for the two alleles.
	if (scalar keys %nucGenotypeHash == 3){
		my @keys_3 = sort keys %nucGenotypeHash;
		foreach (@keys_3){
			$genotypes .= "\t$_";
			$genotypeCounts .= "\t$nucGenotypeHash{$_}";
		}
		my $allele1 = 2*$nucGenotypeHash{$keys_3[0]} + $nucGenotypeHash{$keys_3[1]};
		my $allele2 = 2*$nucGenotypeHash{$keys_3[2]} + $nucGenotypeHash{$keys_3[1]};
		$genotypeCounts .= "\t$allele1\t$allele2";
	#if only one nuclear genotype is found, calculate the allele count. THis assumes the identified genotype is homozygous. "Fixed heterozygosity" would cause a problem here.
	}elsif (scalar keys %nucGenotypeHash == 1){
		my @key = keys %nucGenotypeHash;
		$genotypes .= "\t$key[0]\t??\t??";
		my $allele1 = 2*$nucGenotypeHash{$key[0]};
		$genotypeCounts .= "\t$nucGenotypeHash{$key[0]}\t0\t0\t$allele1\t0";
	#if only 2 of 3 possible nulcear genotypes are found...
	}elsif (scalar keys %nucGenotypeHash == 2){
		my @keys = sort keys %nucGenotypeHash;
		#...and they are both homozygous
		if (substr($keys[0], 0, 1) eq substr($keys[0], 1, 1) && substr($keys[1], 0, 1) eq substr($keys[1], 1, 1)){
			$genotypes .= "\t$keys[0]\t".substr($keys[0], 0, 1).substr($keys[1], 0, 1)."\t$keys[1]";
			my $allele1 = 2*$nucGenotypeHash{$keys[0]};
			my $allele2 = 2*$nucGenotypeHash{$keys[1]};		
			$genotypeCounts .= "\t$nucGenotypeHash{$keys[0]}\t0\t$nucGenotypeHash{$keys[1]}\t$allele1\t$allele2";	
		#... and first one is homozygous (but second is heterozygous)
		}elsif ((substr($keys[0], 0, 1) cmp substr($keys[1], 0, 1)) == 0){
			$genotypes .= "\t$keys[0]\t$keys[1]\t".substr($keys[1], 1, 1).substr($keys[1], 1, 1);
			my $allele1 = 2*$nucGenotypeHash{$keys[0]} + $nucGenotypeHash{$keys[1]};
			my $allele2 = $nucGenotypeHash{$keys[1]};		
			$genotypeCounts .= "\t$nucGenotypeHash{$keys[0]}\t$nucGenotypeHash{$keys[1]}\t0\t$allele1\t$allele2";	
		#...and second one is homozygous (but first is heterozygous)
		}else{
			$genotypes .= "\t".substr($keys[0], 0, 1).substr($keys[0], 0, 1)."\t$keys[0]\t$keys[1]";
			my $allele1 = $nucGenotypeHash{$keys[0]};
			my $allele2 = $nucGenotypeHash{$keys[0]} + 2*$nucGenotypeHash{$keys[1]};		
			$genotypeCounts .= "\t0\t$nucGenotypeHash{$keys[0]}\t$nucGenotypeHash{$keys[1]}\t$allele1\t$allele2";	
		}
	}elsif(scalar keys %nucGenotypeHash == 0){
		return $returnString."\tERROR:NoGenotypes"; 
	}else{
		return $returnString."\tERROR:TooManyGenotypes"; 
	}
	
	$returnString .= $genotypes.$genotypeCounts;
	
	my @sortNucAlleles = sort keys %nucAlleleHash_rand;
	
	$returnString .= "\t$nucAlleleHash_rand{$sortNucAlleles[0]}";
	if ($sortNucAlleles[1]){
		$returnString .= "\t$nucAlleleHash_rand{$sortNucAlleles[1]}";
	}else{
		$returnString .= "\t0";
	}
	
	
	#calculate multi-allelic r^2 measure of LD [see Zhao et al. (2005 Genetical Res.) formulas]
	my $r2;
	my $r2hap;
	my $D;
	my $Dhap;
	my $chisq_df;
	my $chisq_prime;
	my $D2;
	my $nucAlleleCount = scalar keys %nucAlleleHash_rand;
	my $mitoAlleleCount = scalar keys %mitoAlleleHash;
	my $minAlleleCount = min ($nucAlleleCount, $mitoAlleleCount);
	my $nucHomo;
	my $mitoHomo;
	
	#print header info for a genotype matrix to a file that will be analyzed in R
	my $FH_OUT = open_output ("TEMP_R_MATRIX");
	print $FH_OUT "NucAllele";
	foreach (sort keys %mitoAlleleHash){
		print $FH_OUT ",$_";
	}
	

	foreach my $nuc_allele (keys %nucAlleleHash_rand){
		
		#print new row in genotype matrix
		print $FH_OUT "\n$nuc_allele";
		
		my $nuc_allele_freq = $nucAlleleHash_rand{$nuc_allele}/$bothCall;
		if ($nuc_allele_freq == 0 or $nuc_allele_freq == 1){
			return $returnString."\tERROR:NucAlleleFreqZero";
		}
		$nucHomo += $nuc_allele_freq**2;
		$mitoHomo = 0;
		foreach my $mito_allele (sort keys %mitoAlleleHash){
			my $mito_allele_freq = $mitoAlleleHash{$mito_allele}/$bothCall;
			if ($mito_allele_freq == 0 or $mito_allele_freq == 1){
				return $returnString."\tERROR:MitoAlleleFreqZero";
			}
			my $mito_nuc_freq = 0;
			if (exists $nucMitoHash{$nuc_allele . '_' . $mito_allele}){
				$mito_nuc_freq = $nucMitoHash{$nuc_allele . '_' . $mito_allele}/$bothCall;
				print $FH_OUT ",$nucMitoHash{$nuc_allele . '_' . $mito_allele}";
			}else{
				print $FH_OUT ",0";
			}
			
			my $Dij = $mito_nuc_freq - $nuc_allele_freq*$mito_allele_freq;
			my $Dmax;
					
			if ($Dij < 0){
				$Dmax = min($nuc_allele_freq*$mito_allele_freq, (1-$nuc_allele_freq)*(1-$mito_allele_freq));
			}else{
				$Dmax = min($nuc_allele_freq*(1-$mito_allele_freq), (1-$nuc_allele_freq)*$mito_allele_freq);
			}
			$mitoHomo += $mito_allele_freq**2;
			
			$D += $nuc_allele_freq*$mito_allele_freq*abs($Dij/$Dmax);
			$Dhap += $mito_nuc_freq*abs($Dij/$Dmax);
			$r2 += $nuc_allele_freq*$mito_allele_freq*($Dij**2)/($mito_allele_freq*(1-$mito_allele_freq)*$nuc_allele_freq*(1-$nuc_allele_freq));
			$r2hap += $mito_nuc_freq*($Dij**2)/($mito_allele_freq*(1-$mito_allele_freq)*$nuc_allele_freq*(1-$nuc_allele_freq));
			$D2 += ($Dij**2);
			$chisq_df += ($Dij**2)/($nuc_allele_freq*$mito_allele_freq*($nucAlleleCount - 1)*($mitoAlleleCount -1));
			$chisq_prime += ($Dij**2)/($nuc_allele_freq*$mito_allele_freq*($minAlleleCount - 1));
		}
	}
	
	print $FH_OUT "\n";

	#Fisher's exact test in R
	my $p_value;
	system ("Rscript TEMP_R_SCRIPT > TEMP_R_OUT");
	my @R_output = file_to_array ("TEMP_R_OUT");
	if ($R_output[5] =~ /^p-value\s\=\s([e\d\.\-]+)/){
		$p_value = $1;
	}else{
		die ("ERROR: could not parse p-value: $R_output[5]\n");	
	}
	
	my $Dstar = $D2/((1-$nucHomo)*(1-$mitoHomo));
	
	$returnString .= "\t$D\t$Dhap\t$r2\t$r2hap\t$Dstar\t$chisq_df\t$chisq_prime\t$p_value";
	
	#return data summary string that can be printed as output.
	return $returnString;
}

#subroutines to open input and output files and to convert the contents of an input file directly to an array
sub open_file {
	use strict;
	use warnings;

    my($filename) = @_;
    my $fh;

    unless(open($fh, $filename)) {
        print "Cannot open file $filename\n";
        exit;
    }
    return $fh;
}


sub open_output {
	use strict;
	use warnings;

    my($filename) = @_;
    my $fh_output;

    unless(open($fh_output, ">$filename")) {
        print "Cannot open file $filename\n";
        exit;
    }
    return $fh_output;
}

sub file_to_array {
	use strict;
	use warnings;

    my($filename) = @_;

    my @filedata = (  );

    unless( open(GET_FILE_DATA, $filename) ) {
        print STDERR "Cannot open file \"$filename\"\n\n";
        exit;
    }

    @filedata = <GET_FILE_DATA>;

    close GET_FILE_DATA;

    return @filedata;
}


