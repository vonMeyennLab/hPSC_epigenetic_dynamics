## Epigenetic dynamics during capacitation of naïve human pluripotent stem cells

This repository contains all scripts to reproduce the results of the article.

#### Highlights
*	A multi-omics resource of naïve and capacitated/primed human pluripotent stem cells.
*	Chemical resetting of conventional hPSCs followed by capacitation corrects X chromosome epigenetic aberrations.
*	Capacitated cells have mesoderm and ectoderm gene expression signatures while conventional hPSCs show only an ectoderm signature.
*	Promoter H3K27ac marks have a stronger association with naïve-specific expression while H3K4me3 marks with primed-specific expression.

#### Abstract
<p align="justify"> 
Human pluripotent stem cells (hPSCs) are of fundamental relevance in regenerative medicine and the primary source for many novel cellular therapies. The development of naïve culture conditions has led to the expectation that these naïve hPSCs could overcome some of the limitations found in conventional (primed) hPSCs culture conditions, including recurrent epigenetic anomalies. Recent work has shown that transition to the primed state (or capacitation) is necessary for naïve hPSCs to acquire multi-lineage differentiation competence. This pluripotent state transition may recapitulate essential features of human peri-implantation development. Here we studied epigenetic changes during the transition between naïve and primed pluripotency, examining global genomic redistribution of histone modifications, chromatin accessibility, and DNA methylation, and correlating these with gene expression. We identify CpG islands, enhancers, and retrotransposons as hotspots of epigenetic dynamics between pluripotency states. Our results further reveal that hPSC resetting and subsequent capacitation rescue X chromosome-linked epigenetic erosion and reduce the ectoderm-biased gene expression of conventional primed hPSCs.
</p>


### Directory structure
#### 1. :file_folder: ```data/scripts```</p>
&emsp;&emsp;:file_folder: ```nf-core_scripts ```</p>
&emsp;&emsp;&emsp;&emsp;:file_folder: ```design```</p>

&emsp;&emsp;:file_folder:```ChromHMM```&ensp;*Contains the commands used to generate the ChromHMM model (ChromHMM_commands.txt) and the design files for the concatenated and stacked model (inside the folder 'design').*</p>
&emsp;&emsp;&emsp;&emsp;:file_folder: ```design```</p>

#### 2. :file_folder: ```analysis```</p>
&emsp;&emsp;:file_folder: ```functions```</p>
&emsp;&emsp;:file_folder: ```objects```</p>
&emsp;&emsp;&emsp;&emsp;:file_folder: ```1_metadata```</p>
&emsp;&emsp;&emsp;&emsp;:file_folder: ```2_gene_transcript_database```</p>
&emsp;&emsp;&emsp;&emsp;:file_folder: ```3_annotation```</p>
&emsp;&emsp;&emsp;&emsp;:file_folder: ```4_rnaseq```</p>
&emsp;&emsp;&emsp;&emsp;:file_folder: ```5_chipseq_atacseq```</p>
&emsp;&emsp;&emsp;&emsp;:file_folder: ```6_pbat```</p>
&emsp;&emsp;&emsp;&emsp;:file_folder: ```7_counts_inside_regions```</p>
&emsp;&emsp;&emsp;&emsp;:file_folder: ```8_differentially_expressed_genes```</p>
&emsp;&emsp;&emsp;&emsp;:file_folder: ```9_differential_peaks```</p>
&emsp;&emsp;&emsp;&emsp;:file_folder: ```10_DMRs```</p>
&emsp;&emsp;&emsp;&emsp;:file_folder: ```11_annotation_extra```</p>
&emsp;&emsp;&emsp;&emsp;:file_folder: ```12_LOLA_custom```</p>
&emsp;&emsp;:file_folder: ```main```</p>
&emsp;&emsp;&emsp;&emsp;:file_folder: ```01_qc```</p>
&emsp;&emsp;&emsp;&emsp;:file_folder: ```02_genome_wide_analysis```</p>
&emsp;&emsp;&emsp;&emsp;:file_folder: ```03_condition_comparison```</p>
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;:file_folder: ```ChromHMM```</p>
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;:file_folder: ```MOFA```</p>
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;:file_folder: ```X_chromosome_inactivation```</p>
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;:file_folder: ```human_imprints```</p>
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;:file_folder: ```motifs```</p>
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;:file_folder: ```repeats```</p>
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;:file_folder: ```TE_expression```</p>
&emsp;&emsp;&emsp;&emsp;:file_folder: ```04_promoters_expression```</p>