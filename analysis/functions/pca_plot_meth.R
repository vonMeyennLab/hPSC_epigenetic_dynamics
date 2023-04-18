# Function to plot PCA of the methylation data

pca_plot_meth <- function(object,
                          ntop       = +Inf,
                          PCs        = c("PC1", "PC2")){
  
  object <- as.matrix(object)
  
  rv <- rowVars(object)
  
  select <- order(rv, decreasing = TRUE)[seq_len(min(ntop, length(rv)))]
  
  pca <- prcomp(t(object[select, ]))
  
  percentVar <- pca$sdev^2/sum(pca$sdev^2)
  
  d <- tibble(PC1 = pca$x[, 1], PC2 = pca$x[, 2], PC3 = pca$x[, 3], PC4 = pca$x[, 4], sample_id = colnames(object), name = colnames(object))  
  
  percentVar <- pca$sdev^2/sum(pca$sdev^2)
  attr(d, "percentVar") <- percentVar[1:4]
  attr(d, "ntop") <- ntop
  
  principal_components_df <- 
    d %>% 
    left_join(PBAT_metadata %>% select(-file, -batch, -group, -replicate), by = c("sample_id")) %>%
    arrange(cell, day) %>%
    mutate(sample_id = factor(sample_id, levels = unique(sample_id)))
  
  PCA_percentages <- d %>%
    attributes() %>%
    .[["percentVar"]] %>%
    `*`(100) %>%
    round(1) %>%
    setNames(c("PC1", "PC2", "PC3", "PC4"))
  
  ggplot(data = principal_components_df,
         mapping = aes(x      = !!sym(PCs[1]),
                       y      = !!sym(PCs[2]),
                       label  = day,
                       fill   = color)) + 
    geom_point(shape = 21, size = 4, color = "black", show.legend = F) +
    xlab(paste(PCs[1], " (", PCA_percentages[PCs[1]], "%)", sep = "")) +
    ylab(paste(PCs[2], " (", PCA_percentages[PCs[2]], "%)", sep = "")) +
    theme_publication() +
    scale_fill_identity(aes(color)) + 
    theme(
      legend.position = "bottom",
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank()
    )
}
