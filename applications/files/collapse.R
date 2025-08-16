# Define high-level macro-haplogroup mappings
macro_map <- c(
  # African-ancestry macro L
  "L0" = "L", "L1" = "L", "L2" = "L", "L3" = "L", "L4" = "L", "L5" = "L", "L6" = "L",
  # Macro M group
  "M" = "M", "C" = "M", "D" = "M", "E" = "M", "G" = "M", "Q" = "M",
  # Macro N group
  "N" = "N", "A" = "N", "S" = "N", "I" = "N", "W" = "N", "X" = "N", "Y" = "N",
  # Macro R (derived from N)
  "R" = "R", "B" = "R", "F" = "R", "H" = "R", "V" = "R", "J" = "R", "T" = "R",
  "U" = "R", "K" = "R"
)

collapse_haplo <- function(hg, map) {
  # Find all keys where hg starts with the key
  matches <- names(map)[vapply(names(map), function(k) startsWith(hg, k), logical(1))]
  if (length(matches) > 0) {
    # Choose the longest matching prefix for specificity
    best <- matches[which.max(nchar(matches))]
    return(map[[best]])
  }
  return(NA_character_)
}

library(dplyr)

hg <- read.delim("clean_haplogroups.txt")
hg2 <- hg %>%
  mutate(Macro = vapply(Haplogroup, collapse_haplo, character(1), map = macro_map))

table(hg2$Macro)
table(hg2$Macro)/sum(table(hg2$Macro))
