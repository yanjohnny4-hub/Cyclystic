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
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS trip_duration,
  FORMAT_DATE('%A', DATE(started_at)) AS day_of_week,
  EXTRACT(HOUR FROM started_at) AS hour,
  EXTRACT(MONTH FROM started_at) AS month
FROM
  `bike-share-503501.bike_data.final_bikedata`