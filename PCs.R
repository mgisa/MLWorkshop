install.packages("readxl", dependencies = T)
library(readxl)

data <- read_excel("data/Recession.xlsx", sheet = 2)
dim(data)
prin_comp <- prcomp(data[,2:25], scale = TRUE, center = TRUE)
library(caret)
Retained_PCs = preProcess(data[,2:24],
                          method=c( "center", 
                                   "scale", "pca"))
Retained_PCs #Only 9 PCs retained since they are contributing 95% of total variability (variance)in data set.PCs <-predict(Retained_PCs, Recession_data[,2:24])

PCs <- predict(Retained_PCs, data[,2:24])
# Retained PCs 
head(PCs, 3)
#Creating Data from 9 PCs
data<-cbind(PCs, data$Recession)
Recess_data<- data %>%
  as.data.frame()%>% 
  mutate(Recession = data$`data$Recession`) %>% 
  select(-`data$Recession`)
View(Recess_data)
