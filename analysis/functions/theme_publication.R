# Theme to create publication-ready ggplots

theme_publication <- function(base_size = 14) {
  
  (theme_foundation(base_size = base_size) +
     theme(
        plot.title = element_text(
        size       = rel(0.9),
        hjust      = 0,
        vjust      = 0
      ),
      text             = element_text(),
      panel.background = element_rect(colour = NA),
      plot.background  = element_rect(colour = NA),
      panel.border     = element_rect(colour = "black"),
      axis.title       = element_text(size   = rel(0.8)),
      axis.title.y     = element_text(angle  = 90, vjust = 2),
      axis.title.x     = element_text(vjust  = -0.2),
      axis.text        = element_text(),
      axis.ticks       = element_line(size   = 0.5),
      panel.grid.major = element_line(colour = "#f0f0f0"),
      panel.grid.minor = element_line(colour = "#f0f0f0"),
      legend.key       = element_rect(colour = NA),
      legend.position  = "bottom",
      legend.direction = "horizontal",
      legend.key.size  = unit(0.6, "cm"),
      legend.spacing   = unit(0, "cm"),
      legend.title     = element_text(size = 10),
      strip.text       = element_text(face = "bold"),
      strip.background = element_blank()
    ))
}

