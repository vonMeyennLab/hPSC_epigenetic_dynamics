taskset --cpu-list 0-15 \
nextflow run nf-core/rnaseq -r 1.4.2 \
-profile singularity \
--reads /scratch/data/raw/rnaseq_paired_end/'*_R{1,2}.fastq.gz' \
--fasta /scratch/genomes/Homo_sapiens/GRCh38/Ensembl/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa \
--gtf /scratch/genomes/Homo_sapiens/GRCh38/Ensembl/Homo_sapiens.GRCh38.98.gtf \
--bed12 /scratch/genomes/Homo_sapiens/GRCh38/Ensembl/Homo_sapiens.GRCh38.98.bed \
--star_index /scratch/genomes/Homo_sapiens/GRCh38/Ensembl/star \
--reverseStranded \
--outdir /scratch/results/rnaseq_paired_end_results/ \
--email "joao.agostinhodesousa@hest.ethz.ch" \
-name "RNA-Seq paired" \
-w /scratch/tmp/nextflow_tmp/ \
--max_memory '80.GB' \
--max_cpus 16 \
/