# Part 1: Linear Regression to Predict MPG
# Load dplyr package
library(tidyverse, dplyr)

# Import and read the MechaCar_mpg.csv file as a dataframe
car_mpg <- read.csv(file='MechaCar_mpg.csv', check.names=F, stringsAsFactors=F)

# Rename columns
car_mpg <- car_mpg %>%
  rename(
    awd = AWD,
    gclr = ground_clearance,
    span = spoiler_angle,
    lnth = vehicle_length,
    wt = vehicle_weight
  )

# Plotting data
plot(car_mpg)

?lm()
# Perform multiple linear regression using lm()
lm(mpg ~ awd + gclr + span + lnth + wt, data=car_mpg)

# Determine p-value and r-squared value for linear regression model (summary())
summary(lm(mpg ~ awd + gclr + span + lnth + wt, data=car_mpg))


# Part 2: Collecting summary statistics on the pounds per square inch (PSI)
# Load and read Suspension_Coil.csv file as a table
coil_table <- read.csv(file='Suspension_Coil.csv', check.names=F, stringsAsFactors=F)

# Create a total_summary dataframe of PSI using summarize()
?summarize()
total_summary <- coil_table %>% 
  summarize(Mean=mean(PSI), 
            Median=median(PSI),
            Variance=var(PSI),
            SD=sd(PSI),
            .groups='keep')

# Create a lot_summary dataframe of PSI using group_by() and summarize()
lot_summary <- 
  coil_table %>% 
  group_by(Manufacturing_Lot) %>% 
  summarize(Mean=mean(PSI), 
            Median=median(PSI),
            Variance=var(PSI),
            SD=sd(PSI),
            .groups='keep')


# Part 3: T-Tests on Suspension Coils
# Compare sample (all PSIs) versus population mean(1500)
?t.test()
shapiro_results <- shapiro.test(coil_table$PSI) #visualize distribution

t_test_results <- t.test(coil_table$PSI, mu = 1500) 
t.test(log10(coil_table$PSI), mu = (log10(1500))) # adjusted for right skew

# Compare manufacturing lots' PSI versus population mean(1500)
?subset()
# t-test for Lot 1
t.test(x=subset(coil_table, Manufacturing_Lot=="Lot1", select=PSI), mu=1500)

# t-test for Lot 2
t.test(x=subset(coil_table, Manufacturing_Lot=="Lot2", select=PSI), mu=1500)

# t-test for Lot 3
t.test(x=subset(coil_table, Manufacturing_Lot=="Lot3", select=PSI), mu=1500)
