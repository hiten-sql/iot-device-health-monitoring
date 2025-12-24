-- Identify industrial IoT devices that have not pinged in the last 24 hours

WITH tagged_devices AS (
    SELECT
        id AS device_id
    FROM devices_device
    WHERE 'ent_industrial_fleet' = ANY(device_tags)
),
last_ping AS (
    SELECT
        device_fk_id,
        last_ping_time
    FROM devices_devicelatestdata
)
SELECT
    td.device_id,
    lp.last_ping_time,
    CASE
        WHEN lp.last_ping_time IS NULL THEN 'No Data'
        WHEN NOW() - lp.last_ping_time > INTERVAL '24 hours'
            THEN 'Non-Pinging'
        ELSE 'Active'
    END AS device_status
FROM tagged_devices td
LEFT JOIN last_ping lp
    ON td.device_id = lp.device_fk_id;
