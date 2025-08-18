library(dplyr)
macro_map_df <- read.delim("macro.txt", header = TRUE, quote = "\"",
                           stringsAsFactors = FALSE,
                           col.names = c("Haplogroup", "Super.Haplogroup"))
macro_map <- setNames(macro_map_df$Super.Haplogroup, macro_map_df$Haplogroup)

collapse_haplo <- function(hg, map) {
  matches <- names(map)[vapply(names(map), function(k) startsWith(hg, k), logical(1))]
  if (length(matches) > 0) {
    best <- matches[which.max(nchar(matches))]
    return(map[[best]])
  }
  return(NA_character_)
}

hg <- read.delim("clean_haplogroups.txt", stringsAsFactors = FALSE)
hg2 <- hg %>%
  mutate(Macro = vapply(Haplogroup, collapse_haplo, character(1), map = macro_map))
print(table(hg2$Macro))
print(prop.table(table(hg2$Macro)))
write.table(hg2, "haplogroups_with_macro.txt", sep = "\t", row.names = FALSE)
