# libries we'll need
library(ggplot2)
library(reshape2)

# read in data
formantData <- read.csv("formantMeasures.csv")

# plot formants for head
# get F1 measures
ehF1 <- formantData[formantData$vowel == "head", 1:7]
colnames(ehF1) <- c("sound","vowel","20", "35", "50","65", "80")
ehF1 <- melt(ehF1, id=c("sound","vowel"))

# get F2 measures
ehF2 <- formantData[formantData$vowel == "head", c(1:2,8:12)]
colnames(ehF2) <- c("sound","vowel","20", "35", "50","65", "80")
ehF2 <- melt(ehF2, id=c("sound","vowel"))

# plot
ggplot(ehF1, aes(x = variable, colour = sound)) +
  stat_summary(aes(y = value, group = sound, fill = sound), fun.data = mean_cl_boot,
               position = "identity", geom="ribbon", fun.args=list(conf.int=.9), alpha = .5) +  
  stat_summary(aes(y = value, group = sound), position = "identity", geom="line") +
  stat_summary(aes(y = value, group = sound, fill = sound),fun.data = mean_cl_boot,
               position = "identity", geom="ribbon", data = ehF2, fun.args=list(conf.int=.9), alpha = .5) +
  stat_summary(aes(y = value, group = sound), position = "identity", geom="line", data = ehF2) +
  labs(x = "Timepoint of measure (as % of vowel)", y = "Formant Freq. in Hz", title = "Head")

