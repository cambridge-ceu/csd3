# Functions for outputting a user's list of installed packages, and
# reinstalling them on a new system

# Get a data.frame of installed packages and versions
get_packages <- function() {
  # Gets all installed packages
  df <- as.data.frame(
    installed.packages()[, c("Package", "Version")],
    stringsAsFactors = FALSE
  )
  rownames(df) <- NULL
  
  # Add information about R version
  attr(df, "R.version") <- paste0(R.version$major, ".", R.version$minor)
  
  return(df)
}

# Attempt to reinstall packages from CRAN or BioConductor, with 
# preference for CRAN if on both. Requires output from get_packages().
# In addition to installing packages, returns an updated data.frame 
# including the new version numbers, and indication of whether 
# installation was successful. Indicators are one of "success", "fail",
# "base", or "outdated", where "base" indicates the package is part of 
# the standard library that comes with R and thus not reinstalled or 
# updated, and "outdated" indicates the package version 
# installed is older than the one you had on cardio, for example where
# you've installed the developmental version of a package from a github
# page but an older version is on CRAN or BioConductor.
reinstall <- function(package_df) {
  # Attempt to load bioconductor manager
  if(!require("BiocManager", character.only = TRUE, quietly=TRUE)) {
    tryCatch({
      install.packages("BiocManager", repos="https://cloud.r-project.org", 
                       verbose=FALSE, quiet=TRUE)
      library(BiocManager)
    }, error=function(e) {
      warning("Unable to install BiocManager. BioConductor packages ", 
              "will not be installed.")
    })
  }
  
  # Warn if version of R is different to source version, do this at end
  # so message is not lost among all package install messages
  Rvers <- paste0(R.version$major, ".", R.version$minor) 
  if (is.null(attr(package_df, "R.version"))) {
    msg <- ""
  } else if (Rvers != attr(package_df, "R.version")) {
    msg <- paste0("The version of R you're using on CSD3 (", Rvers, 
                 ") is different to version of R you were using on cardio (",
                 attr(package_df, "R.version"), ").")
  } else {
    msg <- ""
  }
  
  # Indicate base packages that should not be reinstalled:
  stdlib <- c("base", "boot", "class", "cluster", "codetools", 
              "compiler", "datasets", "foreign", "graphics", 
              "grDevices", "grid", "KernSmooth", "lattice", "MASS", 
              "Matrix", "methods", "mgcv", "nlme", "nnet", "parallel",
              "rpart", "spatial", "splines", "stats", "stats4", 
              "survival", "tcltk", "tools", "utils")
  package_df <- cbind(package_df, base=ifelse(package_df$Package %in% stdlib, TRUE, FALSE))
  
  # Try installing packages
  for (ii in 1:nrow(package_df)) {
    # Skip if base package
    if (package_df[ii, "base"]) next
    
    # Skip if a newer version is already installed
    pkg <- package_df[ii, "Package"]
    installed <- as.data.frame(
      installed.packages()[, c("Package", "Version")],
      stringsAsFactors = FALSE
    )
    rownames(installed) <- NULL
    if (pkg %in% installed$Package) {
      inst_vers <- installed[installed$Package == pkg, "Version"]
      if (compareVersion(inst_vers, package_df[ii, "Version"]) >= 0) {
        next
      }
    }
      
    tryCatch({ # First try CRAN, then bioconductor
      install.package(package_df[ii, "Package"])
    }, error = function(e) {
      tryCatch({
        BiocManager::install(package_df[ii, "Package"], ask=FALSE)
      }, error=function(e) {
        # could not install but don't crash.
      })
    })
  }
  
  # Get new version information:
  installed <- as.data.frame(
    installed.packages()[, c("Package", "Version")],
    stringsAsFactors = FALSE
  )
  rownames(installed) <- NULL
  
  package_df <- merge(package_df, installed, by="Package", all.x=TRUE,
                      suffixes=c(".cardio", ".csd3"))
  
  package_df <- cbind(package_df, Installation="Success", stringsAsFactors=FALSE)
  package_df[is.na(package_df$Version.csd3), "Installation"] <- "Fail"
  package_df[package_df$base, "Installation"] <- "Base"
  vers_comp <- sapply(1:nrow(package_df), function(ii) {
    if (is.na(package_df$Version.csd3[ii])) {
      NA
    } else {
      compareVersion(package_df$Version.cardio[ii], package_df$Version.csd3[ii])
    }
  })
  package_df[!is.na(vers_comp) & vers_comp > 0, "Installation"] <- "Outdated"
  
  if (msg != "") warning(msg)

  # Get rid of extraneous information and return
  package_df$base <- NULL
  attr(package_df, "R.version") <- NULL
  return(package_df)
}