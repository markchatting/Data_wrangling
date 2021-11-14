setwd("d:\\Users\\mc15243\\Desktop")

file <- read.csv("Copy of Species Project.csv", header=T, sep=",")

#str(file)
file$Stations <- as.character(file$Stations)

df2 <- file

txt <- c("KINGDOM", "PHYLUM", "MAGNOLIOPHYTA ", "CLASS", "ORDER", "FAMILY")
for (i in 1:length(txt)){
	df2 <- df2[grep(txt[i], df2$Stations, invert=TRUE), ]
}

str(df2)


txt <- c("KINGDOM", "PHYLUM", "MAGNOLIOPHYTA ", "CLASS", "ORDER", "FAMILY")
for (i in 1:length(txt)){
	outdf <- file[grep(txt[i], file$Stations, invert=FALSE), ]
}

str(outdf)

df2[is.na(df2)] <- ""
stats_test <- names(df2)
unique_ids <- rep(stats_test[2:length(stats_test)], times = nrow(df2))


output <- matrix(0, nrow = ncol(df2)-1, ncol = nrow(df2))
for(j in 1:nrow(df2)){
	for (i in 1:ncol(df2)-1){
		output[i, j] <- df2[j, 1]
	}
}

output_vec <- as.vector(output)



library(tidyr)
sites <- extract_numeric(unique_ids)



library(stringr)
transects <- str_sub(unique_ids, -1)
transects[transects=="X"] <- ""




df3 <- df2[1:271, 2:86]
a <- matrix(0, nrow = ncol(df3), ncol=nrow(df3))
for(j in 1:ncol(a)){
	for(i in 1:ncol(df3)){
		a[i, j] <- as.character(df3[j, i])
	}
}

a_vec <- as.vector(a)

outmat <- matrix(0, nrow =85*271, ncol=5)
for (i in 1:length(output_vec)){
	outmat[i, ] <- cbind(unique_ids[i], sites[i], transects[i], output_vec[i], a_vec[i])
}

outmat <- data.frame(outmat)
names(outmat) <- c("Code", "Station", "Transect", "Species", "Count")
outmat[1:50, 5]
str(outmat)

write.csv(outmat, file = "outmat.csv", row.names=FALSE)


##########################################################################################################

			#		END		#

##########################################################################################################
