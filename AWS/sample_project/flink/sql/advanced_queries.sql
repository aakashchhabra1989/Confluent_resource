-- Advanced Stream Processing Examples
-- Collection of more complex SQL statements

-- 1. Create sink table for results
CREATE TABLE user_activity_sink (
  username STRING,
  activity_count BIGINT,
  window_start TIMESTAMP(3),
  window_end TIMESTAMP(3)
) WITH (
  'connector' = 'confluent-kafka',
  'kafka.bootstrap.servers' = 'YOUR_BOOTSTRAP_SERVERS',
  'topic' = 'user-activity-results',
  'value.format' = 'json'
);

-- 2. Insert processed data into sink
INSERT INTO user_activity_sink 
SELECT username, activity_count, window_start, window_end 
FROM user_activity_summary;

-- 3. Real-time user filtering
CREATE VIEW active_users AS
SELECT username, email
FROM user_profiles
WHERE registrationDate > CURRENT_TIMESTAMP - INTERVAL '24' HOUR;

-- 4. Join example (if you have multiple streams)
-- CREATE TABLE user_events AS
-- SELECT 
--   p.username,
--   p.email,
--   e.event_type,
--   e.event_timestamp
-- FROM user_profiles p
-- JOIN user_event_stream e ON p.id = e.user_id;
