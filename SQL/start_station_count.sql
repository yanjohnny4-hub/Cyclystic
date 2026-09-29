SELECT
  member_casual,
  start_station_name,
  end_station_name,
  start_station_id,
  end_station_id,
  COUNT(start_station_name) AS start_station_count,
FROM
  `bike-share-503501.bike_data.final_bikedata`
GROUP BY
  member_casual,
  start_station_name,
  end_station_name,
  start_station_id,
  end_station_id
ORDER BY
  start_station_count
  DESC