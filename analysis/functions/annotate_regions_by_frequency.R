# Function that returns the annotation frequency of a granges object

annotate_regions_by_frequency <-
  
  function(genomic_regions,
           annotation_list,
           name,
           with_duplicated_annotations = FALSE,
           apply_GRanges_reduce        = FALSE){
    
    # collapse adjacent enriched regions
    if(apply_GRanges_reduce == TRUE){
      
      genomic_regions <- GenomicRanges::reduce(genomic_regions)
      
    } else if (apply_GRanges_reduce != TRUE & apply_GRanges_reduce != FALSE) {
     
      print("apply_GRanges_reduce needs to be TRUE or FALSE")
      stop()
    }

    # find overlaps between the regions and annotation_list
    result <- as.data.frame(suppressWarnings(findOverlaps(genomic_regions, 
                                                          annotation_list,
                                                          ignore.strand = TRUE)))
    
    # fetch annotation names
    result$annotation <- names(annotation_list)[result$subjectHits]
    
    # rank by annotation precedence
    result <- result[order(result$subjectHits),]   
    
    
    if(with_duplicated_annotations == TRUE){
      
      # count the number of peaks in each annotation category
      result <- group_by(.data = result, annotation)
      result <- summarise(.data = result, counts = length(annotation))
      
      result$frequency <- with(result, counts/length(genomic_regions))
      
    } else {
      
      # remove overlapping annotations
      result <- subset(result, !duplicated(queryHits))
      
      # count the number of peaks in each annotation category
      result <- group_by(.data = result, annotation)
      result <- summarise(.data = result, counts = length(annotation))
      
      result$frequency <- with(result, counts/sum(counts))
      
    }

    result$experiment <- name

    return(result)
  }
