# Function to generate the PCA plot data with DESeq2 transformed counts as input

# Required packages
require(matrixStats)
require(DESeq2)

pca_normalized_counts_data <- function (object,
                                        metadata,
                                        ntop       = +Inf,
                                        returnData = TRUE){
  
  rv <- rowVars(object)
  
  select <- order(rv, decreasing = TRUE)[seq_len(min(ntop, length(rv)))]
  
  pca <- prcomp(t(object[select, ]))
  
  percentVar <- pca$sdev^2/sum(pca$sdev^2)
  
  d <- data.frame(PC1 = pca$x[, 1], PC2 = pca$x[, 2], PC3 = pca$x[, 3], PC4 = pca$x[, 4], group = metadata$group, name = colnames(object))
  
  if (returnData == TRUE) {
    attr(d, "percentVar") <- percentVar[1:4]
    attr(d, "ntop") <- ntop
    return(d)
  }
}
