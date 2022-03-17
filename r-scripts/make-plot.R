#load the package ggplot2
library(ggplot2)

#load the combined Oxford/Melbourne data and define it as object "plot_df"
plot_df <- read.csv("average-rainfall.csv")

#create the plot, use geometry functions to manipulate its appearance, and define the plot as object "g"
g <- ggplot(
  data = plot_df,
  mapping = aes(
    x = as.integer(month_num),
    y = average_rainfall,
    colour = location)) +
  geom_point() +
  geom_line() +
  labs(
    x = NULL,
    y = "Average rainfall (mm)",
    colour = "City",
    title = "Rainfall",
    subtitle = "Monthly average (1855--2015)") +
  scale_x_continuous(
    breaks = plot_df$month_num[seq(2,12,2)],
    labels = plot_df$month[seq(2,12,2)]) +
  theme_classic() +
  theme(axis.text.x = element_text(angle = -45))

#view the graph prior to saving
g

#Produce a PNG file of the graph and export it to the "outputs" directory
ggsave(filename = "outputs/result.png",
       plot = g,
       height = 10.5, width = 14.8,
       units = "cm")

#Produce a TXT file with information about the versions of R and all loaded packages and export it to the "outputs" directory
sink(file = "outputs/package-versions.txt")
sessionInfo()
sink()
