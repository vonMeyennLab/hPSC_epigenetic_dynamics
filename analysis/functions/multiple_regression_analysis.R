# Functions for the multiple regression analysis

#######################################################
# R-squared
bs_rsq <-
  function(data, formula, indices) {
    
    d <- data[indices,]
    m <- lm(formula, data = d)
    return(summary(m)$adj.r.squared)
    
  }


get_global_rsq_plot_data <- 
  function(multiple_regression_df, regression_formula, boot_times){
    
    global_rsq <- map(multiple_regression_df %>% named_group_split(group), ~ boot(data = .x, formula = regression_formula, statistic = bs_rsq, R = boot_times))
    
    # Global result arrays
    global_rsq_plot_data <- 
      map(global_rsq,
          function(x){
            
            rsq <- array();
            rsq.l <- array();
            rsq.u <- array();
            rsqcount <- 0;
            
            rsqcount <- 0
            bci <- boot.ci(x, type="perc", conf=0.95, index=1);
            rsqcount <- rsqcount + 1;
            rsq[rsqcount] <- x$t0;
            rsq.l[rsqcount] <- bci$percent[,4];
            rsq.u[rsqcount] <- bci$percent[,5];
            names(rsq)[rsqcount] <- "HAS";
            c(rsq, rsq.l, rsq.u)
          }
          
      ) %>%
      as_tibble() %>%
      t %>%
      as.data.frame() %>%
      rownames_to_column("group") %>%
      dplyr::rename(rsq = V1, rsq_l = V2, rsq_u = V3)
    
    return(global_rsq_plot_data)
    
  }
#######################################################






#######################################################
# T-statistics

bs_tstat <- function(data, formula, indices) {
  
  d <- data[indices, ];
  m <- lm(formula, data=d);
  return(summary(m)$coefficients[2:nrow(summary(m)$coefficients),3]);
  
}
#######################################################





#######################################################
# Regression coefficient estimate

bs_estimate <- function(data, formula, indices) {
  d <- data[indices, ];
  m <- lm(formula, data=d);
  return(summary(m)$coefficients[2:nrow(summary(m)$coefficients),1]);
}




get_regression_estimate_data <- 
  function(multiple_regression_df, regression_formula, boot_times){
    
    results_estimate <- 
      map(multiple_regression_df %>% named_group_split(group), ~ boot(data = .x, formula = formula, statistic = bs_estimate, R = boot_times))
    
    results_estimate_plot_data <- 
      map2_dfr(results_estimate,
               names(results_estimate),
               function(x, y){
                 
                 # Get 95% intervals
                 ci.l <- array();
                 ci.u <- array();
                 regression_coef <- array();
                 
                 for (i in 1:length(x$t0)) {
                   bci <- boot.ci(x, type="perc", conf=0.95, index=i);
                   regression_coef[i] <- bci$t0;
                   ci.l[i] <- bci$percent[,4];
                   ci.u[i] <- bci$percent[,5];
                 }
                 names(regression_coef) <- names(x$t0);
                 
                 
                 tibble(variable = names(regression_coef),
                        regression_coefficient = regression_coef, 
                        confidence_interval_low = ci.l,
                        confidence_interval_high = ci.u)	%>%
                   arrange(dplyr::desc(regression_coefficient)) %>% 
                   mutate(variable = case_when(variable == "`ATAC-Seq`" ~ "ATAC-Seq",
                                               variable == "CGITRUE" ~ "CGI",
                                               TRUE ~ variable),
                          variable = factor(variable, levels = unique(variable))) %>% 
                   mutate(group = y)
               }
      ) %>% mutate(group = factor(group, levels =
                                    c(
                                      "HNES1 d0",
                                      "cR-H9-EOS d0",
                                      "HNES1 d3",
                                      "cR-H9-EOS d3",
                                      "HNES1 d10",
                                      "cR-H9-EOS d10",
                                      "cR-H9-EOS d20X", 
                                      "cR-H9-EOS d20E",
                                      "H9-EOS"
                                    )))
    
    return(results_estimate_plot_data)
  }
#######################################################







#######################################################
# Relative importance of regressors

get_relative_importance_data <- 
  function(multiple_regression_df, regression_formula, boot_times){
    
    relaimpo_boot <- 
      map(multiple_regression_df %>% named_group_split(group), ~ boot.relimp(lm(regression_formula, data = .x), b = boot_times, type = c("lmg", "last", "first", "pratt", "betasq"), rank = F, diff = TRUE, rela = TRUE))
    
    relaimpo_plot_data <- 
      map2_dfr(relaimpo_boot,
               names(relaimpo_boot),
               function(x, y){
                 
                 booteval <- 
                   booteval.relimp(x, sort = TRUE)
                 
                 tibble(
                   seqtype     = booteval@namen %>% .[-1],
                   lmg         = booteval@lmg,
                   lmg_lower   = as.vector(booteval@lmg.lower),
                   lmg_upper   = as.vector(booteval@lmg.upper),
                   last        = booteval@last,
                   last_lower  = as.vector(booteval@last.lower),
                   last_upper  = as.vector(booteval@last.upper),
                   first       = booteval@first,
                   first_lower = as.vector(booteval@first.lower),
                   first_upper = as.vector(booteval@first.upper),
                   group       = y
                 )	
               }
      ) %>% mutate(group = factor(group, levels =
                                    c(
                                      "HNES1 d0",
                                      "cR-H9-EOS d0",
                                      "HNES1 d3",
                                      "cR-H9-EOS d3",
                                      "HNES1 d10",
                                      "cR-H9-EOS d10",
                                      "cR-H9-EOS d20X", 
                                      "cR-H9-EOS d20E",
                                      "H9-EOS"
                                    )))
    
    return(relaimpo_plot_data)
  }
#######################################################
