# Summer months
SELECT
  member_casual,
  ROUND(
    AVG(trip_duration),
    2
  ) AS avg_trip,
  MIN(trip_duration) AS min_trip,
  MAX(trip_duration) AS max_trip,
  ROUND(
    AVG(hour),
    2
  ) AS avg_hour,
  APPROX_TOP_COUNT(day_of_week, 3) AS mode_day_of_week
FROM
  `bike-share-503501.bike_data.final_bikedata`
WHERE
  month = 6 OR
  month = 7 OR
  month = 8
GROUP BY
  member_casual;