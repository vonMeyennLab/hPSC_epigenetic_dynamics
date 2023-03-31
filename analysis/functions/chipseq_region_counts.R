# Function to count the number of reads overlapping granges object regions

chipseq_region_counts <- 
  function(bamFiles, gr_object){
    
    # use summarizeOverlaps to count the reads
    read_count_over_windows <- summarizeOverlaps(gr_object, bamFiles, inter.feature = FALSE, ignore.strand = TRUE) %>% assays() %>% .[[1]]
    
    # remove the .mLb.clN.sorted.bam suffix
    colnames(read_count_over_windows) <- sub('.mLb.clN.sorted.bam', '',   colnames(read_count_over_windows))
    
    # changing the column names so it is the same as the sample_id from the metadata dataframe
    colnames(read_count_over_windows) <- 
      read_count_over_windows %>%
      colnames() %>%
      str_replace("cR_H9_EOS", "cR-H9-EOS") %>%
      str_replace("H9_EOS", "H9-EOS") %>%
      str_replace("_R", "_rep")
    
    return(read_count_over_windows)
  }
