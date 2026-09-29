# Cyclystic
## Overview
Paragraph 1
Cyclystic is a fictional bike-share company located in Chicago. Cyclystic offers single-ride passes, full-day passes, and annual membership. Customers who purchase single-ride or full-day passes are considered casual riders, while those who own an annual membership are considered Cyclistic members. The company's financial analysts have determined that annual members are much more profitable compared to casual riders. 

Paragraph 2
In this scenario, I am a data analyst working on the marketing analyst team at the company. Lily Moreno, the director of marketing and my manager, believes that maximizing the number of annual members is the key to future growth; rather than creating a marketing campaign that targets new customers, she believes the company should instead focus on converting casual riders to members.

## Stakeholders
* **Cyclystic**:  A bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike.
* **Lily Moreno** The director of marketing and my manager. Moreno is responsible for the development of campaigns and initiatives to promote the bike-share program. These may include email, social media, and other channels.
* **Cyclistic marketing analytics team**: A team of data analysts who are responsible for collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy.
* **Cyclystic executive team**: The executive team will decide whether to approve the recommended marketing campaign.

## Business Task
My business task was to create marketing strategies designed to convert casual riders into annual members. 
3 questions shaped my case study:
* How do annual members and casual riders use Cyclystic bikes differently?
* Why would casual members buy Cyclistic annual memberships?
* How can Cyclystic use digital media to influence casual riders to become members?

## Perparing the data
I downloaded 11 months worth of historic trip data from [this database](https://divvy-tripdata.s3.amazonaws.com/index.html).
I obtained data from July 2025 to June 2026. Next, I uploaded them into Google BigQuery and merged them with the query titled "merge_12_months," storing the query into a table titled "all_trips."
![A code snippet of "merge_12_months"](https://ibb.co/JRCnDr4j)
After reviewing the table, I noticed there was missing and duplicate data. I used the query "filtering_bikes" to remove any duplicate or null values. 
```
SELECT
  *
FROM
  (
    SELECT
      ride_id,
      rideable_type,
      started_at,
      ended_at,
      start_station_name,
      start_station_id,
      end_station_name,
      end_station_id,
      member_casual,
      COUNT(*)
    FROM
      `bike-share-503501.bike_data.all_trips`
    GROUP BY
      ride_id,
      rideable_type,
      started_at,
      ended_at,
      start_station_name,
      start_station_id,
      end_station_name,
      end_station_id,
      member_casual
    HAVING
      COUNT(*) = 1
  )
WHERE
  TIMESTAMP_DIFF(ended_at, started_at, SECOND) > 0 AND
  start_station_name IS NOT NULL AND
  start_station_id IS NOT NULL AND
  end_station_name IS NOT NULL AND
  end_station_id IS NOT NULL
```
Lastly, I extracted each entry's starting hour and month with the following:
```
TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS trip_duration,
FORMAT_DATE('%A', DATE(started_at)) AS day_of_week,
EXTRACT(HOUR FROM started_at) AS hour,
EXTRACT(MONTH FROM started_at) AS month
```
I saved the data obtained from "filtering_bikes" with the extracted hour and month into a new table called "final_bikedata."

## Analysis
To find how casual riders differed from annual members, I queried "final_bikedata" to find the average trip duration of casual riders and members. I also looked at the average hour and month each group rode in, as well as the their top 3 most common days. All of this is done in the query titled "analysis."
I also extracted the starting location of the ride, aggregating the location's name by count. This is done in the query called "start_station_count."

Paragraph 2
Next, I looked for seasonal differences between the two groups. For my analysis, winter is designated as months 12, 1, and 2, spring as months 3, 4, and 5, summer as months 6, 7, and 8, and fall as 9, 10, and 11. The SELECT statement has the same body as my main analysis, however I included a new WHERE clause to filter out the months.

### Findings
* Casual riders ride about twice as long on average compared to members
* Causal riders most commonly ride on the weekends, while members tend to ride in the middle of the week
* The starting locations for casual riders are near the pier and other recreational areas, while the starting locations for members are deeper in the city of Chicago.
* The average time of day and most common days of the week spent riding generally stay the same no matter the season
  * Casual riders ride longer than members across all seasons

*All of my queries can be found in the folder titled "SQL"*

# Sharing my findings
I created a Google Slides presentation to share my findings, which can be found in the folder titled "slides."
Key Findings include:
* Casual riders prefer to ride over the weekends
  ![A chart comparing days of the week of casual riders and members](https://ibb.co/hRdv4PmM)
* Casual riders ride longer on average
  ![A chart comparing the average ride duration of casual riders and members](https://ibb.co/wZfMtLpf)
* Casual riders ride near the shore and other recreational areas
  ![A map of the most common starting locations of casual riders](https://ibb.co/C5crFPcG)

*I generated these graphs using by inputting my SQL analyses into Google Sheets. For more information, please view the folder titled "sheets."*

## Final Recommendations
I proposed the following recommendations:
* Geo-target ads near beaches, piers, and parks
* Advertise the convenience and flexibility of membership
* Promote health benefits of rides along scenic routes
### Final Recommendation
Frame membership as a way for casual riders to get more out of the recreational riding they already do

# Author
My name is Cai Xin (Johnny) Yan and I created this case study to refine my skills as a data analyst and a presenter. To add my opinion, I enjoyed every step of the process to create this case study. It felt really amazing to see all of the pieces fall into place as I was analyzing the data -- how I could see patterns between casual riders and members and how exactly each group differed.
