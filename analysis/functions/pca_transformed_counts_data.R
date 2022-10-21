# Function to generate the PCA plot data with DESeq2 transformed counts as input

# Required packages
require(matrixStats)
require(DESeq2)

pca_transformed_counts_data <- function (object,
                                         metadata,
                                         intgroup   = "condition",
                                         ntop       = +Inf,
                                         returnData = TRUE){
  
  rv <- rowVars(assay(object))
  
  select <- order(rv, decreasing = TRUE)[seq_len(min(ntop, length(rv)))]
  
  pca <- prcomp(t(assay(object)[select, ]))
  
  percentVar <- pca$sdev^2/sum(pca$sdev^2)
  
  if (!all(intgroup %in% names(colData(object)))) {
    stop("the argument 'intgroup' should specify columns of colData(dds)")
  }
  
  intgroup.df <- as.data.frame(colData(object)[, intgroup, drop = FALSE])
  
  group <- if (length(intgroup) > 1) {
    factor(apply(intgroup.df, 1, paste, collapse = " : "))
  }
  
  else {
    colData(object)[[intgroup]]
  }
  
  d <- data.frame(PC1 = pca$x[, 1], PC2 = pca$x[, 2], PC3 = pca$x[, 3], PC4 = pca$x[, 4], group = group, 
                  intgroup.df, name = colnames(object))
  
  if (returnData == TRUE) {
    attr(d, "percentVar") <- percentVar[1:4]
    attr(d, "ntop") <- ntop
    return(d)
  }
}
