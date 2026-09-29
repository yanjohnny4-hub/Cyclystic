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