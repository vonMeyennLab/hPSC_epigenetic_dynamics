nextflow run nf-core/methylseq -r 1.4 \
-profile singularity \
--reads '/scratch/data/raw/pbat/sample_4661/*_R{1,2}.fastq.gz' \
--fasta /scratch/genomes/Homo_sapiens/GRCh38/Ensembl/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa \
--bismark_index /scratch/genomes/Homo_sapiens/GRCh38/Ensembl/BismarkIndex/ \
--igenomes_ignore \
--pbat \
--comprehensive \
--outdir '/scratch/results/pbat_sample_4661/' \
--email 'joao.agostinhodesousa@hest.ethz.ch' \
-name "PBAT Sample 4661" \
-w '/scratch/tmp/nextflow_tmp/' \
--max_memory '90.GB' \
--max_cpus 64 \
/
