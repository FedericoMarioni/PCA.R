# PCA

# How to use the prcomp() function to do PCA
# How to draw a PCA plot using base graphics and ggplot2
# How to determine how much variation each PC accounts for
# How to examine the loading scores to determine what variables 
# have the largest effect on the graph

# Generate a fake data set

data.matrix <- matrix(nrow=100, ncol=10)

colnames(data.matrix) <- c(
  paste("wt", 1:5, sep=""),
  paste("ko", 1:5, sep=""))

rownames(data.matrix) <- paste("gene", 1:100, sep="")

for(i in 1:100) {
  wt.values <- rpois(5, lambda = sample(x=10:1000, size = 1))
  ko.values <- rpois(5, lambda = sample(x=10:1000, size = 1))
  
  data.matrix[i,] <- c(wt.values, ko.values)
}

head(data.matrix)

# Call prcomp() to do PCA on our data

pca <- prcomp(t(data.matrix), scale=TRUE)

# Plot x

plot(pca$x[,1], pca$x[,2])  # x contains the PCs for drawing a graph

# How much variation in the original data each PC accounts for?

pca.var <- pca$sdev^2

pca.var.per <- round(pca.var/sum(pca.var)*100,1)

barplot(pca.var.per, main = "Scree Plot", xlab = "Principal Component",
        ylab = "Percent Variation")  

# PC1 accounts for almost all of the variation in the data

library(ggplot2)

pca.data <- data.frame(Sample = rownames(pca$x),
                       X= pca$x[,1],
                       Y= pca$x[,2])

ggplot(data=pca.data, aes(x=X, y=Y, label=Sample)) + 
  geom_text() +
  xlab(paste("PC1 - ", pca.var.per[1], "%", sep="")) + 
  ylab(paste("PC2 - ", pca.var.per[2], "%", sep="")) +
  theme_bw() +
  ggtitle("My PCA Graph")

# How to use loading scores to determine which genes have the largest
# effect on where samples are plotted in the PCA plot

loading_scores <- pca$rotation[,1]
gene_scores <- abs(loading_scores)
gene_score_ranked <- sort(gene_scores, decreasing=TRUE)
top_10_genes <- names(gene_score_ranked[1:10])

top_10_genes

pca$rotation[top_10_genes, 1] 
