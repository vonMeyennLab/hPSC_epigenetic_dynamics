nextflow run nf-core/atacseq -r 1.1.0 \
-profile singularity \
--input '/home/josousa/ngs_projects/design_atacseq.csv' \
--macs_gsize 2.7e9 \
--fasta /scratch/genomes/Homo_sapiens/GRCh38/Ensembl/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa \
--gtf /scratch/genomes/Homo_sapiens/GRCh38/Ensembl/Homo_sapiens.GRCh38.98.gtf \
--blacklist /scratch/genomes/Homo_sapiens/GRCh38/Blacklist/hg38-blacklist.v2.bed \
--bwa_index /scratch/genomes/Homo_sapiens/GRCh38/Ensembl/BWAIndex/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa \
--gene_bed /scratch/genomes/Homo_sapiens/GRCh38/Ensembl/Homo_sapiens.GRCh38.98.bed \
--mito_name "MT" \
--igenomes_ignore \
--outdir '/scratch/results/atacseq_results/' \
--email 'joao.agostinhodesousa@hest.ethz.ch' \
-w '/scratch/tmp/nextflow_tmp/' \
-name "ATAC-Seq" \
--min_reps_consensus 1 \
--save_macs_pileup \
--max_memory '90.GB' \
--max_cpus 64 \
/
