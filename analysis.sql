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
  ROUND(
    AVG(month),
    2
  ) AS avg_month,
  APPROX_TOP_COUNT(day_of_week, 3) AS mode_day_of_week
FROM
  `bike-share-503501.bike_data.final_bikedata`
GROUP BY
  member_casual;