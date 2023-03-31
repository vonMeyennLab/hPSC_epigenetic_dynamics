# Function to get the methylation percentage inside granges regions

get_perc_meth_in_granges <- 
  function(PBATdb_data, sample_group_name, regions_gr, coverage_more_or_equal_to){
    
    PBATdb_data_df <- 
      PBATdb_data %>%
      methylKit::unite(min.per.group = 1L) %>%
      methylKit::pool(sample.ids = sample_group_name) %>%
      as("GRanges") %>%
      .[.$coverage1 >= coverage_more_or_equal_to]
    
    
    overlaps_df <- 
      PBATdb_data_df %>%
      IRanges::findOverlaps(regions_gr, ignore.strand = TRUE) %>% 
      as.data.frame()
    
    
    perc_meth_df <- 
      PBATdb_data_df %>% 
      as.data.frame() %>%
      .[overlaps_df$queryHits, ] %>% 
      mutate(index      = overlaps_df$subjectHits,
             perc_meth = numCs1 / (numCs1 + numTs1)) %>%
      group_by(index) %>%
      summarise(n_meth_positions        = n(),
                mean_perc_meth          = mean(perc_meth))
    
    regions_gr %>%
      as.data.frame() %>%
      rownames_to_column("index") %>%
      mutate(index = as.integer(index)) %>%
      full_join(perc_meth_df, by = "index") %>% 
      dplyr::rename(!!sample_group_name := mean_perc_meth) %>% 
      select(-index)
    
  }