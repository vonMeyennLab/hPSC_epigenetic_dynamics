# Function to split dataframe by group and gives the element of the list the name of the group.

named_group_split <- function(.tbl, ...) {
  
  grouped <- group_by(.tbl, ...)
  names <- rlang::eval_bare(rlang::expr(paste(!!!group_keys(grouped), sep = " / ")))
  
  grouped %>% 
    group_split() %>% 
    rlang::set_names(names)
  
}