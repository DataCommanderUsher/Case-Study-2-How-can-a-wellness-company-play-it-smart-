# Case-Study-2-How-can-a-wellness-company-play-it-smart-
## 1. A clear summary of the business task
Analyze smart device usage data from non-Bellabeat consumers to identify trends in daily health habits. 
These insights will be applied to one Bellabeat product to inform a high-level marketing strategy that 
unlocks new growth opportunities for the company.

# 2. A description of all data sources used
**Data Selection & Organization:** The analysis utilizes the FitBit Fitness Tracker Data (Mobius) sourced from Kaggle.
* **Primary Dataset:** I selected dailyActivity_merged.csv from the Fitabase Data 4.12.16-5.12.16 directory. 
This file serves as the master dataset, consolidating daily metrics for steps, distance, intensities, and calories, rendering 
the individual dailySteps, dailyCalories, and dailyIntensities files redundant.
* **Supplementary Datasets:**
  - **sleepDay_merged.csv:** Used to analyze sleep patterns and correlations with activity levels.
  - **hourlySteps_merged.csv:** Used to identify peak activity times throughout the day.
  - **weightLogInfo_merged.csv:** Used to assess the frequency of weight logging behavior among users.

**Integrity Check (ROCCC):**
- **Reliability:** Low. Data is self-reported by only 30 users, leading to potential sampling bias.
- **Originality:** Low. Third-party data collected via Amazon Mechanical Turk, not directly from Fitbit.
- **Comprehensive:** Medium. Contains rich micro-data (minutes/hours) but lacks demographic context (gender, age) which is critical for Bellabeat's female-focused strategy.
- **Current:** No. Data is from 2016, which may not reflect post-pandemic health habits.
- **Cited:** Yes. Public domain license (CC0).

# 3. Documentation of any cleaning or manipulation of data

# 4. A summary of your analysis

# 5. Supporting visualizations and key findings

# 6. Your top high-level content recommendations based on your analysis
