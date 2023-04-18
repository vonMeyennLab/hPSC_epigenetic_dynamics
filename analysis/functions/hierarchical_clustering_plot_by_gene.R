# Function to make a hiearchical clustering plot from transformed counts (by gene)

# Required packages
require(pheatmap)

hierarchical_clustering_plot_by_gene <- function(transf_counts,
                                                 metadata,
                                                 calculation_type,
                                                 ntop,
                                                 edb){
  
  # ------------------------------------- #
  # selecting the ntop most variable genes for clustering
  rv <- rowVars(assay(transf_counts))
  
  select <- order(rv, decreasing = TRUE)[seq_len(min(ntop, length(rv)))]
  
  transf_counts_filtered <- transf_counts[select, ]
  
  rownames(transf_counts_filtered) <- edb[match(rownames(transf_counts_filtered), edb$gene_id), "gene_name"]
  # ------------------------------------- #

  # ------------------------------------- #
  if(calculation_type == "euclidean"){
    
    data_matrix <- assay(transf_counts_filtered) %>% t %>% scale %>% t
    
    hclust_object_row <- hclust(dist(data_matrix, method = "euclidean"), method = "complete")
    hclust_object_col <- hclust(dist(t(data_matrix), method = "euclidean"), method = "complete")
  }
  
  if(calculation_type == "spearman"){
    
    data_matrix <- assay(transf_counts_filtered) %>% t %>% scale %>% t
    
    
    hclust_object_row <- hclust(dist(1-cor(t(data_matrix), method = "spearman")), method = "complete")
    hclust_object_col <- hclust(dist(1-cor(data_matrix, method = "spearman")), method = "complete")
  }
  
  if(calculation_type == "pearson"){
    
    data_matrix <- assay(transf_counts_filtered) %>% t %>% scale %>% t
    
    
    hclust_object_row <- hclust(dist(1-cor(t(data_matrix), method = "pearson")), method = "complete")
    hclust_object_col <- hclust(dist(1-cor(data_matrix, method = "pearson")), method = "complete")
  }
  # ------------------------------------- #
  
  # ------------------------------------- #
  annotation_df_col <- 
    t(data_matrix) %>%
    as.matrix() %>%
    as.data.frame() %>%
    rownames_to_column("sample_id") %>%
    left_join((metadata %>% select(-file)), by = "sample_id") %>% 
    select(cell, day, sample_id) %>% 
    column_to_rownames("sample_id")
  
  annotation_df_row <- 
    data_matrix %>%
    as.matrix() %>%
    as.data.frame() %>%
    rownames_to_column("gene_name") %>% 
    left_join((edb %>% select(gene_name, gene_biotype)) %>% unique, by = "gene_name") %>% 
    select(gene_name, gene_biotype) %>% 
    column_to_rownames("gene_name")
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
    mat               = as.matrix(data_matrix),
    color             = colorRampPalette(rev(brewer.pal(n = 7, name = "RdYlBu")))(255),
    cluster_rows      = hclust_object_row,
    cluster_cols      = hclust_object_col,
    cutree_rows       = 3,
    cutree_cols       = 3,
    annotation_row    = annotation_df_row,
    annotation_col    = annotation_df_col,
    annotation_colors = annotation_colors_df,
    treeheight_row    = 100,
    treeheight_col    = 100,
    silent            = F,
    main              = calculation_type
  )
  # ------------------------------------- #
}
