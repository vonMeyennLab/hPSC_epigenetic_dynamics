suppressPackageStartupMessages(library(tidyverse))


####### Calculate variance

intensity.difference <- function (expression, sem, window.proportion = 0.01) 
  
{
  return.frame <- data.frame(expression, sem, index = 1:length(expression))
  return.frame <- return.frame[order(return.frame$expression), ]
  return.frame$p.value <- 1
  return.frame$local.sd <- 0
  return.frame$z.score <- 0
  window.size <- as.integer(nrow(return.frame) * window.proportion)
  half.window.size <- as.integer(window.size/2)
  sapply(1:nrow(return.frame), function(x) {
    start <- x - half.window.size
    if (start < 0) 
      start <- 0
    end <- start + window.size
    if (end > nrow(return.frame)) {
      end <- nrow(return.frame)
      start <- end - window.size
    }
    local.sems <- return.frame$sem[start:end]
    local.mean <- mean(local.sems)
    local.sd <- sqrt(mean((local.sems-local.mean)^2))
    local.p <- pnorm(return.frame$sem[x], mean = local.mean, sd = local.sd)
    if (local.p > 0.5) 
      local.p <- (1 - local.p)
    return.frame$z.score[x] <<- (return.frame$sem[x]-local.mean)/local.sd
    return.frame$local.sd[x] <<- local.sd
    return.frame$p.value[x] <<- local.p
  })
  return.frame$fdr.value <- p.adjust(return.frame$p.value, method = "fdr")
  return.frame <- return.frame[order(return.frame$index), ]
  return(return.frame)
}
