# Function to calculate jaccard coefficient

calc_jaccard_coef <- function(gr1, gr2, ignore.strand = TRUE){
  
  intersect <- 
    GenomicRanges::intersect(gr1, gr2, ignore.strand = ignore.strand) %>% GenomicRanges::reduce() %>% width %>% sum
  
  union <- 
    GenomicRanges::union(gr1, gr2, ignore.strand = ignore.strand) %>% GenomicRanges::reduce() %>% width %>% sum
  
  return(intersect/union)
  
}
