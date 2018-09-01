# Plotting the output of FactoMineR's PCA using ggplot2
#
# load libraries
library(FactoMineR)
library(ggplot2)
library(scales)
library(grid)
library(plyr)
library(gridExtra)
#
# start with a clean slate
rm(list=ls(all=TRUE)) 
#
# load example data from the FactoMineR package
data(decathlon)
#
# compute PCA
res.pca <- PCA(decathlon, quanti.sup = 11:12, quali.sup=13, graph = FALSE)
#
# extract some parts for plotting
PC1 <- res.pca$ind$coord[,1]
PC2 <- res.pca$ind$coord[,2]
labs <- rownames(res.pca$ind$coord)
PCs <- data.frame(cbind(PC1,PC2))
rownames(PCs) <- labs
#
# Just showing the individual samples...
ggplot(PCs, aes(PC1,PC2, label=rownames(PCs))) + 
  geom_text() 
#
# Now get supplementary categorical variables
cPC1 <- res.pca$quali.sup$coor[,1]
cPC2 <- res.pca$quali.sup$coor[,2]
clabs <- rownames(res.pca$quali.sup$coor)
cPCs <- data.frame(cbind(cPC1,cPC2))
rownames(cPCs) <- clabs
colnames(cPCs) <- colnames(PCs)
#
# Put samples and categorical variables (ie. grouping
# of samples) all together
p <- ggplot() + theme_bw(base_size = 20) 
# no data so there's nothing to plot...
# add on data 
p <- p + geom_text(data=PCs, aes(x=PC1,y=PC2,label=rownames(PCs)), size=4) 
p <- p + geom_text(data=cPCs, aes(x=cPC1,y=cPC2,label=rownames(cPCs)),size=10)
p # show plot with both layers
#
# clear the plot
dev.off()
#
# Now extract variables
#
vPC1 <- res.pca$var$coord[,1]
vPC2 <- res.pca$var$coord[,2]
vlabs <- rownames(res.pca$var$coord)
vPCs <- data.frame(cbind(vPC1,vPC2))
rownames(vPCs) <- vlabs
colnames(vPCs) <- colnames(PCs)
#
# and plot them
#
pv <- ggplot() + theme_bw(base_size = 20) 
# no data so there's nothing to plot
# put a faint circle there, as is customary
angle <- seq(-pi, pi, length = 50) 
df <- data.frame(x = sin(angle), y = cos(angle)) 
pv <- pv + geom_path(aes(x, y), data = df, colour="grey70") 
#
# add on arrows and variable labels
pv <- pv + geom_text(data=vPCs, aes(x=vPC1,y=vPC2,label=rownames(vPCs)), size=4) + xlab("PC1") + ylab("PC2")
pv <- pv + geom_segment(data=vPCs, aes(x = 0, y = 0, xend = vPC1*0.9, yend = vPC2*0.9), arrow = arrow(length = unit(1/2, 'picas')), color = "grey30")
pv # show plot 
#
# clear the plot
dev.off()
#
# Now put them side by side
#
library(gridExtra)
grid.arrange(p,pv,nrow=1)
# 
# Now they can be saved or exported...
#
# tidy up by deleting the plots
#
dev.off()