# Function to normalize counts inside granges regions

chipseq_normalized_counts <- 
  function(ReadCounts, Metadata){
    
    # removing the input samples
    read_count_over_windows <-
      ReadCounts %>%
      as.data.frame()
    
    # filter the metadata so that includes only the samples used in the ChIP-Seq and ATAC-Seq
    metadata_filtered <- 
      Metadata %>%
      filter(sample_id %in% names(read_count_over_windows)) %>%
      arrange(match(sample_id, names(read_count_over_windows)))
    
    # creating a DESeq data object and removing the low counts
    dds <- DESeqDataSetFromMatrix(countData = read_count_over_windows,
                                  colData   = metadata_filtered,
                                  design    = ~ 1)
    
    normalized_counts <- DESeq2::estimateSizeFactors(dds) %>% DESeq2::counts(normalized = TRUE)
    
    return(normalized_counts)
  }
