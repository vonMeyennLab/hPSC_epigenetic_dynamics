# Function to annotate each region in a GRanges object

annotate_regions <-
  function(genomic_regions,
           annotation_list,
           with_duplicated_annotations = FALSE,
           apply_GRanges_reduce        = FALSE){
    
    # collapse adjacent regions
    if(apply_GRanges_reduce == TRUE){
      
      genomic_regions <- GenomicRanges::reduce(genomic_regions)
      
    } else if (apply_GRanges_reduce != TRUE & apply_GRanges_reduce != FALSE) {
      
      print("apply_GRanges_reduce needs to be TRUE or FALSE")
      stop()
    }
    
    # find overlaps between the regions and annotation_list
    result <- as.data.frame(suppressWarnings(findOverlaps(genomic_regions, annotation_list,
                                                          ignore.strand = TRUE)))
    
    # fetch annotation names
    result$annotation <- names(annotation_list)[result$subjectHits]
 
    
    if(with_duplicated_annotations == FALSE){
      
      # remove overlapping annotations
      result <- subset(result, !duplicated(queryHits))
      
    }
    
    # subset the genomic regions object to select only the ones that overlapped with annotated regions
    genomic_regions_gr_subset <- genomic_regions[result$queryHits]
    
    # add the assigned annotation to each lines of the GRanges object
    genomic_regions_gr_subset$annotation <- result$annotation
    
    return(full_join(genomic_regions %>% as.data.frame(), genomic_regions_gr_subset %>% as.data.frame()))
    
  }
