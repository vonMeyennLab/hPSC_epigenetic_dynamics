# Script to load all packages, annotations, function, options, and metadata

# -------------------- PACKAGES -------------------- #
# org.Hs.eg.db issue workaround
options(connectionObserver = NULL)

# Packages
suppressPackageStartupMessages({
  library(ggplot2)
  library(tidyverse)
  library(RColorBrewer)
  library(ComplexHeatmap)
  library(DESeq2)
  library(tximport)
  library(clusterProfiler)
  library(patchwork)
  library(gridExtra)
  library(methylKit)
  library(magrittr)
  library(stringr)
  library(janitor)
  library(ggthemes)
  library(future)
  library(furrr)
  library(GenomicRanges)
  library(GenomicAlignments)
  library(reshape2)
  library(rlist)
  library(Biobase)
  library(BEclear)
  library(ensembldb)
  library(annotatr)
  library(conflicted)
  library(org.Hs.eg.db)
  library(BSgenome.Hsapiens.UCSC.hg38)
  library(TxDb.Hsapiens.UCSC.hg38.knownGene)
  library(scales)
  library(DEGreport)
  library(pheatmap)
  library(DRIMSeq)
  library(DEXSeq)
  library(data.table)
  library(purrr)
  library(MOFA2)
  library(reticulate)
  library(colorspace)
  library(ggalluvial)
  library(relaimpo)
  library(boot)
  library(DiffBind)
  library(profileplyr)
  library(LOLA)
  library(ggvenn)
  library(rtracklayer)
  library(EnrichedHeatmap)
  library(parallel)
  library(dmrseq)
  library(bsseq)
  library(Mfuzz)
  library(AnnotationDbi)
  library(BSgenome)
  library(ggpubr)
})

# resolving package conflicts
conflict_prefer("select"  , "dplyr")
conflict_prefer("filter"  , "dplyr")
conflict_prefer("count"   , "dplyr")
conflict_prefer("summarize", "dplyr")
conflict_prefer("reduce"  , "purrr")
conflict_prefer("simplify", "purrr")
conflict_prefer("Position", "base")
conflict_prefer("unname", "base")
conflict_prefer("rowVars" , "matrixStats")
conflict_prefer("pheatmap", "pheatmap")
conflict_prefer("value"   , "future")
conflict_prefer("predict", "stats")
conflict_prefer("magrittr", "set_names")
# ------------------------------------------------ #


# -------------------- GENES and TRANSCRIPTS DATABASE -------------------- #
# Loading ensembl gene database
edb <- EnsDb("output/database/Homo_sapiens.GRCh38.98_ensDb.sqlite")

# extracting the gene attributes from the ensembl database 
edb_gene_attributes <- genes(edb, columns = c("gene_id", "gene_name", "gene_biotype")) %>% as.data.frame()

# Loading ensembl trancript database
txdb <- loadDb("output/database/Homo_sapiens.GRCh38.98_txDb.sqlite")

# Fetching the transcript and gene ids
txdf <- AnnotationDbi::select(txdb, keys(txdb, "GENEID"), "TXNAME", "GENEID") %>%
  mutate(ntx = table(GENEID)[match(GENEID, names(table(GENEID)))])
# ------------------------------------------------------------------------ #


# ---------------------------- FUNCTIONS -------------------------------- #
list.files("analysis/functions", full.names = T) %>% .[!str_detect(., "load_project_packages.R")] %>% walk(source)
# ------------------------------------------------------------------------ #


# ----------------------------- METADATA --------------------------------- #
load("output/database/metadata.RData")
# ------------------------------------------------------------------------ #


# ----------------------- GENOME ANNOTATIONS ----------------------------- #
genome_annotation <- readRDS("output/database/genome_annotation.rds")
# ------------------------------------------------------------------------ #


# ------------------------------ OPTIONS --------------------------------- #
# Python options
reticulate::use_python(python = "/usr/bin/python3")

options(future.globals.maxSize = 188743680000) # 180 Gb
# ------------------------------------------------------------------------ #
