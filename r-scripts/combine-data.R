#define Melbourne data as the object "melb_df" and 
melb_df <- read.table(
  file = "data/melbourne.csv",
  header = TRUE,
  sep = ",",
  skip = 11)

#Use the as.numeric() function to create a vector and define it as the object "mean_rainfall_melb"
mean_rainfall_melb <- as.numeric(melb_df[24,2:13])

#define Oxford data as the object "ox_df" and name its columns
ox_df <- read.table(
  file = "data/oxford.txt",
  header = FALSE,
  col.names = c("year", "month", "x1", "x2", "x3", "rain", "x4"),
  skip = 7,
  na.strings = "---",
  nrows = 12 * (2020 - 1853))

#Define objects
year_mask <- (1855 <= ox_df$year) & (ox_df$year <= 2015)
tmp <- ox_df[year_mask,c("month","rain")]
tmp$rain <- as.numeric(
  gsub(
    pattern = "\\*",
    replacement = "",
    x = tmp$rain))

#Use the aggregate() function to calculate summary statistics and define them as "mean_rainfall_ox"
mean_rainfall_ox <- aggregate(
  x = tmp,
  by = list(month = tmp$month),
  FUN = mean)$rain

#Define month titles
months <- c(
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December")

#Combine Oxford and Melbourne datasets into "plot_df" and include month titles and mean rainfall data
plot_df <- data.frame(
  month = rep(months, 2),
  month_num = rep(1:12, 2),
  location = rep(c("Melbourne", "Oxford"), each = 12),
  average_rainfall = c(mean_rainfall_melb, mean_rainfall_ox))

#Produce a summary table of the combined dataset and export it to the "outputs" directory
write.table(x = plot_df,
            file = "outputs/average-rainfall.csv",
            sep = ",",
            row.names = FALSE)
