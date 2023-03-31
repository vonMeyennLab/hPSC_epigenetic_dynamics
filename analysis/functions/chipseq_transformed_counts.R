# Function to transform counts inside granges regions

chipseq_transformed_counts <- 
  function(ReadCounts, Metadata){
    
    # removing the input samples
    read_count_over_windows_noinput <-
      ReadCounts %>%
      as.data.frame() %>%
      select(-starts_with("INPUT"))
    
    # filter the metadata so that includes only the samples used in the ChIP-Seq and ATAC-Seq
    metadata_filtered <- 
      Metadata %>%
      filter(sample_id %in% names(read_count_over_windows_noinput)) %>%
      arrange(match(sample_id, names(read_count_over_windows_noinput)))
    
    # creating a DESeq data object and removing the low counts
    dds <- DESeqDataSetFromMatrix(countData = read_count_over_windows_noinput,
                                  colData = metadata_filtered,
                                  design  = ~ 1)
    
    transformed_counts <- vst(object = dds, blind = T)
    
    return(transformed_counts)
  }
