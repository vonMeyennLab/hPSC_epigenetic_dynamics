# Function to make PCA plot

# Required packages
require(tidyverse)
require(ggthemes)

pca_transformed_counts_plot <- function(pca_results_object, metadata, PCs){
  
  principal_components_df <- pca_results_object %>%
                              left_join(metadata %>% select(sample_id, group, color, day, cell) %>% unique) %>%
                              arrange(cell, day) %>%
                              mutate(group = factor(group, levels = unique(group)))
  
  PCA_percentages <- pca_results_object %>%
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
