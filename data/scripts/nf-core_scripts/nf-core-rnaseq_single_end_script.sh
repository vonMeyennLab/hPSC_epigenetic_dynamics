nextflow run nf-core/rnaseq -r 1.4.2 \
-profile singularity \
--singleEnd \
--reads /scratch/data/raw/rnaseq_single_end/'*.fastq.gz' \
--fasta /scratch/genomes/Homo_sapiens/GRCh38/Ensembl/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa \
--gtf /scratch/genomes/Homo_sapiens/GRCh38/Ensembl/Homo_sapiens.GRCh38.98.gtf \
--bed12 /scratch/genomes/Homo_sapiens/GRCh38/Ensembl/Homo_sapiens.GRCh38.98.bed \
--star_index /scratch/genomes/Homo_sapiens/GRCh38/Ensembl/star \
--reverseStranded \
--outdir /scratch/results/rnaseq_single_end_results/ \
--email "joao.agostinhodesousa@hest.ethz.ch" \
-name "RNA-Seq single-end" \
-w /scratch/tmp/nextflow_tmp/ \
--max_memory '80.GB' \
--max_cpus 16 \
--pseudo_aligner salmon \
/
