## Epigenetic dynamics during capacitation of naïve human pluripotent stem cells
[![DOI](https://zenodo.org/badge/632503416.svg)](https://zenodo.org/badge/latestdoi/632503416)

#### Abstract
<p align="justify"> 
Human pluripotent stem cells (hPSCs) are of fundamental relevance in regenerative medicine. Naïve hPSCs hold promise to overcome limitations of conventional (primed) hPSCs, including recurrent epigenetic anomalies. Naïve-to-primed transition (capacitation) follows transcriptional dynamics of human embryonic epiblast and is necessary for somatic differentiation from naïve hPSCs. We found that capacitated hPSCs are transcriptionally closer to the embryonic epiblast than conventional hPSCs. This prompted us to comprehensively study epigenetic and related transcriptional changes during capacitation. Our results show that CpG islands, gene regulatory elements, and retrotransposons are hotspots of epigenetic dynamics during capacitation, and indicate possible distinct roles of specific epigenetic modifications in gene expression control between naïve and primed hPSCs. Surprisingly, PRC2 activity was dispensable for the capacitation. We find that capacitated hPSCs acquire an epigenetic state similar to conventional hPSCs. Significantly, however, the X chromosome erosion frequently observed in conventional female hPSCs is reversed by resetting and subsequent capacitation.
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
&emsp;&emsp;&emsp;&emsp;:file_folder: ```05_expression_comparison```</p>
