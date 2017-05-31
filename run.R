args <- commandArgs(TRUE)

# If no args, output the task JSON to make this container self-describing

if (length(args) == 0) {
  system("cat tasks.json")
  quit()
}

# Load inputs

require(phytools)
require(aRbor)

tree <- read.tree(args[1])
table <- read.csv(args[2])
method <- args[3]
column <- args[4]
outfile <- args[5]

# This code is directly from "Phylogenetic signal" on arbor.arborworkflows.com

td <- make.treedata(tree, table)
td <- select(td, which(colnames(td$dat)==column))
phy <- td$phy
dat <- td$dat

charType <- aRbor:::detectCharacterType(dat[[1]], cutoff=0.2)

if(charType=="discrete"){
  result <- physigArbor(td, charType=charType, signalTest="pagelLambda")
}
if(charType=="continuous"){
  if(method=="lambda") result <- physigArbor(td, charType=charType, signalTest="pagelLambda")
  if(method=="K") result <- physigArbor(td, charType=charType, signalTest="Blomberg")
}

result <- t(as.data.frame(unlist(result)))
rownames(result) <- NULL

# Output the model fit

write.csv(result, outfile)
