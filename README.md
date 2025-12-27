# Case-Study-2-How-can-a-wellness-company-play-it-smart-
# 1. A clear summary of the business task
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
**Data Cleaning & Transformation Log**: To ensure data integrity and usability for analysis, the following cleaning processes were executed in R (Posit):

**1. Standardization & Formatting**
* **Naming Conventions:** Renamed all columns to snake_case style (e.g., ActivityDate → activity_date) to ensure consistency across all tables.
* **Date Parsing**: Converted character string dates (e.g., "4/12/2016") into standard Date objects (YYYY-MM-DD). This was critical for accurate merging, as daily_activity used a date format while sleep_day originally included timestamps.

**2. Quality Control & Deduplication**
* **Duplicate Removal:** Identified and removed 3 duplicate records from the sleep_day dataset.
  * Method: Used the distinct() function to eliminate rows where all column values were identical, ensuring statistical accuracy for sleep averages.
* **User Validation:** Audited unique user IDs across datasets.
  * Finding: daily_activity contains 33 unique users; sleep_day contains 24 unique users.

**3. Strategic Data Exclusion**
* **Weight Log Exclusion:** The weight_log dataset was excluded from the final analysis.
  * Rationale: Only 8 unique users (approx. 24% of the sample) recorded weight data. This sample size is statistically insignificant and would introduce bias if used to make general recommendations.

**4. Data Integration (The Master Merge)**
* **Merging Strategy:** Performed an inner join on daily_activity and sleep_day datasets using id and date as the primary keys.
  * Outcome: Created a consolidated combined_data dataframe containing roughly 413 complete records. This master dataset links daily physical intensity (steps, calories) directly to sleep quality (minutes asleep) for correlation analysis.

# 4. A summary of your analysis
Analysis of the Fitbit usage data reveals three distinct behavioral patterns among the user group. These trends highlight a clear disconnect between "intent" (buying the tracker) and "action" (reducing sedentary time), representing a prime opportunity for Bellabeat's coaching features.
**1. The "Weekend Warrior" Trap (Sedentary Behavior)** The data exposes a concerning level of sedentary behavior.
* **Finding:** The average user spends significant time (often >10 hours) in sedentary states.
* **Correlation:** Regression analysis (Visual 2) suggests a negative correlation between sedentary minutes and sleep duration. Users with higher sedentary time tend to sleep fewer minutes.
* **Interpretation:** Merely wearing a tracker does not automatically reduce sedentary habits. Users need active "nudges" during the day, not just a summary at the end of it.
**2. Time-of-Day Activity PeaksActivity** is not distributed evenly throughout the day.
* **Finding:** Activity peaks significantly between 5:00 PM and 7:00 PM (likely post-work) and around 12:00 PM to 2:00 PM (lunch).
* **The Gap:** Activity levels drop sharply after 8:00 PM and remain low until 8:00 AM.
* **Interpretation:** Users have established "active windows." The opportunity lies in expanding these windows—specifically, motivating light activity during the morning hours (8 AM - 11 AM) where steps are currently low.
**3. The Caloric Reality**
* **Finding:** There is a strong positive correlation between steps taken and calories burned.
* **Interpretation:** While obvious, this validates the device's utility for weight management. However, since the Weight Log data was sparse (only 8 users), we can infer that while users care about burning calories, they dislike the manual friction of logging weight.

# 5. Supporting visualizations and key findings
The analysis of 30+ Fitbit users over a 30-day period revealed three critical behaviors that define the "Wellness Gap"—the difference between having a tracker and actually being healthy.

**Finding 1: The "Sedentary Cycle" Impacts Sleep**
**Visual:** <img width="870" height="422" alt="image" src="https://github.com/user-attachments/assets/cdfa35b5-a617-4b75-a2b0-d5d3e6017c05" />
* **Observation:** There is a clear negative correlation between sedentary time and sleep duration. Users who spent more time sedentary (10+ hours) tended to sleep significantly less.
* **Key Insight:** Inactivity isn't just a weight issue; it is a rest issue. Users likely do not realize that their "desk job" lifestyle is actively sabotaging their sleep quality.

**Finding 2: The "Active Window" is Narrow**
**Visual:** <img width="870" height="426" alt="image" src="https://github.com/user-attachments/assets/5ee1bc54-c27c-498e-ae85-967470c41a6e" />

* **Observation:** Activity is not consistent. It peaks predictable at lunch (12 PM - 2 PM) and post-work (5 PM - 7 PM). Crucially, there is a massive "Activity Valley" during the morning work block (9 AM - 11 AM) where users are almost entirely stationary.
* **Key Insight:** Users are "reactive" movers—they move when they have to (commute/lunch). They lack "proactive" movement habits during deep work sessions.

**Finding 3: The Rejection of Manual Data Entry**
**Visual:** <img width="844" height="424" alt="image" src="https://github.com/user-attachments/assets/6d344c91-51b8-4731-8d46-99d492cd7799" />

* **Observation:** While 33 users consistently tracked steps (automated), only 8 users logged their weight (manual).
* **Key Insight:**  The modern wellness consumer rejects friction. If data collection isn't automated, they abandon it. Marketing strategies that rely on users "journaling" or "logging" food/weight will likely fail.

# 6. Your top high-level content recommendations based on your analysis
Based on the data, Bellabeat should pivot its marketing from generic "fitness tracking" to specific "wellness coaching." Here are the three pillars of that strategy:
* **Recommendation 1: The "Beauty Sleep" Campaign**
  * **The Data:** High sedentary time correlates with poor sleep.
  * **The Strategy:** Position the Bellabeat Leaf/Time not as a step tracker, but as a "Sleep Restoration" tool.
  * **The Content:** Run social media ads with the hook: "Sitting all day is stealing your sleep." Feature the app's ability to alert users when they've been sedentary too     long, framing the notification as a "Sleep Saver" rather than a "Move Alert." This appeals directly to the health/beauty-conscious female demographic Bellabeat targets.

* **Recommendation 2: "Reclaim Your Morning" (Timed Notifications)**
  * **The Data:** Users are inactive between 8:00 AM and 11:00 AM.
  * **The Strategy:** Update the Bellabeat App to feature "Micro-Movement" challenges specifically during these hours.
  * **The Content:** Create a marketing series called "The 10 AM Reset." Show busy women using the Bellabeat Leaf to take 5-minute wellness breaks (stretching/water) during     their morning meetings. Market the device as a companion for the "Working Woman" who needs energy, not just a gym rat.

* **Recommendation 3: Market "Frictionless Wellness" (The Spring Bottle)**
  * **The Data:** Users abandoned the manual weight log (8 users vs 33 users).
  * **The Strategy:** Aggressively market the Bellabeat Spring (Smart Water Bottle) as the solution to "Manual Logging Fatigue."
  * **The Content:** “Stop guessing, start glowing.” Highlight that Bellabeat products track for you. Since users hate manual entry, emphasize that the Spring bottle tracks hydration automatically. Use the "failed weight log" insight internally to prioritize developing smart scale integrations or removing manual entry features that clutter the app.
