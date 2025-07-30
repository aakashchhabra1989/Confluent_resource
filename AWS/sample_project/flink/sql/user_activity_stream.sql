-- User Activity Stream Processing
-- This SQL creates a windowed aggregation of user activity

CREATE TABLE user_activity_summary AS
SELECT 
  username,
  COUNT(*) as activity_count,
  TUMBLE_START(registrationDate, INTERVAL '1' HOUR) as window_start,
  TUMBLE_END(registrationDate, INTERVAL '1' HOUR) as window_end
FROM user_profiles
GROUP BY username, TUMBLE(registrationDate, INTERVAL '1' HOUR);
