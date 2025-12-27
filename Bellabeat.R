#Install libraries firt
install.packages("tidyverse")
install.packages("janitor")
install.packages("lubridate")

#Load needed Libraries
library(tidyverse)
library(janitor)
library(lubridate)

#Load the Datasets
daily_activity <- read_csv("https://raw.githubusercontent.com/DataCommanderUsher/Case-Study-2-How-can-a-wellness-company-play-it-smart-/refs/heads/main/Datasets/dailyActivity_merged.csv")
sleep_day <- read_csv("https://raw.githubusercontent.com/DataCommanderUsher/Case-Study-2-How-can-a-wellness-company-play-it-smart-/refs/heads/main/Datasets/sleepDay_merged.csv")
hourly_steps <- read_csv("https://raw.githubusercontent.com/DataCommanderUsher/Case-Study-2-How-can-a-wellness-company-play-it-smart-/refs/heads/main/Datasets/hourlySteps_merged.csv")
weight_log <- read_csv("https://raw.githubusercontent.com/DataCommanderUsher/Case-Study-2-How-can-a-wellness-company-play-it-smart-/refs/heads/main/Datasets/weightLogInfo_merged.csv")

#Clean Names
daily_activity <- clean_names(daily_activity)
sleep_day <- clean_names(sleep_day)
hourly_steps <- clean_names(hourly_steps)
weight_log <- clean_names(weight_log)

head(daily_activity)

# 4. Fix Date format to correct date
daily_activity$activity_date <- mdy(daily_activity$activity_date)
weight_log$date <- mdy_hms(weight_log$date)

head(sleep_day)

# Fixing date format for sleep_day to date and correct time
sleep_day$sleep_day <- mdy_hms(sleep_day$sleep_day)
hourly_steps$activity_hour <- mdy_hms(hourly_steps$activity_hour)

#Check actual number of users, is it 30?
cat("Unique Users in Daily Activity:", n_distinct(daily_activity$id), "\n")
cat("Unique Users in Sleep Logs:", n_distinct(sleep_day$id), "\n")
cat("Unique Users in Weight Logs:", n_distinct(weight_log$id), "\n")

#Check for Duplicates
cat("Duplicates in Daily Activity:", sum(duplicated(daily_activity)), "\n")
cat("Duplicates in Sleep Logs:", sum(duplicated(sleep_day)), "\n")
cat("Duplicates in Weight Logs:", sum(duplicated(weight_log)), "\n")

#Remove Duplicates in Sleep Logs
sleep_day <- sleep_day %>% distinct()

#We are no longer using weight_log dataset

# Verify if we removed duplicates
cat("Remaining Duplicates:", sum(duplicated(sleep_day)), "\n")

#Fix the "Date vs DateTime" issue befor joining
daily_activity <- daily_activity %>%
  rename(date = activity_date)

sleep_day <- sleep_day %>%
  mutate(date = as_date(sleep_day))

#Merge the two dataset
combined_data <- merge(daily_activity, sleep_day, by=c("id", "date"))

#Check 
head(combined_data)
nrow(combined_data)

# --- Visual 1: Activity vs. Calories
v1 <- ggplot(combined_data, aes(x=total_steps, y=calories)) +
  geom_point(alpha=0.5, color="darkblue") +
  geom_smooth(method="lm", color="red") +
  labs(title="Correlation: Daily Steps vs. Calories Burned",
       x="Total Steps", y="Calories") +
  theme_minimal()

print(v1)

# --- Visual 2: Insight (Sedentary vs. Sleep
v2 <- ggplot(combined_data, aes(x=sedentary_minutes, y=total_minutes_asleep)) +
  geom_point(alpha=0.5, color="purple") +
  geom_smooth(method="lm", color="orange") +
  labs(title="Impact of Sedentary Behavior on Sleep Quality",
       x="Sedentary Minutes (Daily)", y="Minutes Asleep") +
  theme_minimal()

print(v2)

# --- Visual 3: Timing" Insight
hourly_steps <- hourly_steps %>%
  mutate(hour = hour(activity_hour))

hourly_summary <- hourly_steps %>%
  group_by(hour) %>%
  summarise(average_steps = mean(step_total))

v3 <- ggplot(hourly_summary, aes(x=hour, y=average_steps)) +
  geom_col(fill="#69b3a2") +
  labs(title="Average Activity Intensity by Hour of Day",
       x="Hour of Day (24h)", y="Average Steps") +
  theme_minimal()

print(v3)