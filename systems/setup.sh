#!/usr/bin/bash

module load ceuadmin/R
export csd3=~/cambridge-ceu/csd3
cd ${CEUADMIN}
rm -f ceuadmin.png generic.png genetics.png
grep -e Generic ${csd3}/systems/setup.md | grep "^[|]" | awk '{print $4}' > generic.lst
grep -e Genetics -e Proteomics ${csd3}/systems/setup.md | grep "^[|]" | awk '{print $4}' > genetics.lst
grep -e Genetics -e Generic -e Proteomics ${csd3}/systems/setup.md | grep "^[|]" | awk '{print $4}' | wc -l
Rscript -e '
  library(RColorBrewer)
  library(dplyr)
  library(tm)
  library(wordcloud)
  options(width=110);
  ceuadmin <- Sys.getenv("CEUADMIN")
  wc <- function(modules,png)
  {
    print(length(modules))
    docs <- Corpus(VectorSource(modules))
    m <- TermDocumentMatrix(docs) %>%
         as.matrix()
    words <- sort(rowSums(m),decreasing=TRUE)
    freq <- rpois(length(words),lambda=3)
    png(png,,res=300,height=10,width=10,units="in")
    wordcloud(names(words), freq, min.freq = 1, max.words=200, random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))
    dev.off()
  }
  set.seed(1234321)
  generic <- scan("generic.lst",what="")
  genetics <- scan("genetics.lst",what="")
  wc(generic,"generic.png")
  wc(genetics,"genetics.png")
  unlink(c("generic.lst","genetics.lst"))
  modules <- setdiff(dir(ceuadmin),c("lib","misc","sources","generic.png","genetics.png"))
  wc(modules,"ceuadmin.png")
  print(modules)
'
mv *.png ${csd3}/systems
