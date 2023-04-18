# Function to make a hiearchical clustering plot from transformed counts (by sample)

# Required packages
require(pheatmap)

hierarchical_clustering_plot_by_sample <- function(transf_counts,
                                                   metadata,
                                                   calculation_type,
                                                   ntop){
  
  # ------------------------------------- #
  # selecting the ntop most variable genes for clustering
  if("matrix" %in% class(transf_counts)){transf_counts <- transf_counts}
  if("DESeqTransform" %in% class(transf_counts)){transf_counts <- assay(transf_counts)}
  
  rv <- rowVars(transf_counts)
  
  select <- order(rv, decreasing = TRUE)[seq_len(min(ntop, length(rv)))]
  
  transf_counts <- transf_counts[select, ]
  # ------------------------------------- #
  
  # ------------------------------------- #
  if(calculation_type == "euclidean"){
    
    cor_dist_matrix <- data_matrix <- dist(t(transf_counts), method = "euclidean")
    hclust_object <- hclust(cor_dist_matrix, method = "complete")
    color_object <- colorRampPalette(brewer.pal(n = 7, name = "RdYlBu"))(255)
    
    }
  
  if(calculation_type == "spearman"){
    
    cor_dist_matrix <- data_matrix <- cor(transf_counts, method = "spearman")
    hclust_object <- hclust(dist(1-cor_dist_matrix), method = "complete") 
    color_object <- colorRampPalette(rev(brewer.pal(n = 7, name = "RdYlBu")))(255)
  }
  
  if(calculation_type == "pearson"){
    
    cor_dist_matrix <- data_matrix <- cor(transf_counts, method = "pearson")
    hclust_object <- hclust(dist(1-cor_dist_matrix), method = "complete") 
    color_object <- colorRampPalette(rev(brewer.pal(n = 7, name = "RdYlBu")))(255)
  }
  # ------------------------------------- #
  
  # ------------------------------------- #
  annotation_df <- cor_dist_matrix %>%
                    as.matrix() %>%
                    as.data.frame() %>%
                    rownames_to_column("sample_id") %>%
                    left_join((metadata %>% select(-file)), by = "sample_id") %>% 
                    select(cell, day, sample_id) %>% 
                    column_to_rownames("sample_id")
  # ------------------------------------- #
  
  # ------------------------------------- #
  annotation_colors_df <- list(
                                cell = c("cR-H9-EOS" = brewer.pal(6, "YlOrRd")[5],
                                         "HNES1"     = brewer.pal(6, "Blues")[5],
                                         "H9-EOS"    = "darkgrey"),
                                day = c(
                                        "0"      = brewer.pal(9, "Greens")[1],
                                        "1"      = brewer.pal(9, "Greens")[3],
                                        "2"      = brewer.pal(9, "Greens")[5],
                                        "3"      = brewer.pal(9, "Greens")[7],
                                        "7"      = "darkolivegreen",
                                        "10"     = brewer.pal(9, "Greens")[9],
                                        "20X"    = brewer.pal(10, "BrBG")[3],
                                        "20E"    = brewer.pal(10, "BrBG")[2],
                                        "H9-EOS" = brewer.pal(10, "BrBG")[1]
                                        )
  )
  # ------------------------------------- #
  
  # ------------------------------------- #
  pheatmap(
    mat               = as.matrix(cor_dist_matrix),
    color             = color_object,
    border_color      = NA,
    cluster_rows      = hclust_object,
    cluster_cols      = hclust_object,
    cutree_rows       = 3,
    cutree_cols       = 3,
    annotation_row    = annotation_df,
    annotation_col    = annotation_df,
    annotation_colors = annotation_colors_df,
    treeheight_row    = 50,
    treeheight_col    = 50,
    silent            = F,
    main              = calculation_type,
  )
 # ------------------------------------- #
}

