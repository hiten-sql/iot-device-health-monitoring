/*
  Servicing Due Estimation
  -----------------------
  Predicts next service date based on:
  - Engine hours
  - Average daily usage
*/

WITH devices AS (
    SELECT id AS device_id
    FROM devices_device
    WHERE 'ent_industrial_fleet' = ANY(device_tags)
),

agg AS (
    SELECT
        device_fk_id,
        SUM(total_distance)/1000.0 AS kms,
        SUM(EXTRACT(EPOCH FROM running_time))/3600.0 AS engine_hrs,
        COUNT(day) FILTER (
            WHERE EXTRACT(EPOCH FROM running_time)/3600.0 > 0.25
        ) AS active_days
    FROM data_day
    JOIN devices d ON d.device_id = data_day.device_fk_id
    GROUP BY device_fk_id
)

SELECT
    device_fk_id,
    kms,
    engine_hrs,
    active_days,
    ROUND(engine_hrs / NULLIF(active_days,0),2) AS avg_engine_hrs_per_day,
    CEIL(engine_hrs / 500.0) * 500 AS next_service_at,
    (CEIL(engine_hrs / 500.0) * 500 - engine_hrs) AS hrs_remaining,
    CURRENT_DATE + (
        ROUND(
            (CEIL(engine_hrs / 500.0) * 500 - engine_hrs) /
            NULLIF(engine_hrs / NULLIF(active_days,0),0)
        )
    )::INT AS est_service_date
FROM agg
WHERE kms > 10
ORDER BY est_service_date;
