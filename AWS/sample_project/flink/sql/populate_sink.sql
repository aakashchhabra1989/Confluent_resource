-- Populate Sink Table
-- This SQL inserts processed data into the sink table

INSERT INTO user_activity_sink 
SELECT username, activity_count, window_start, window_end 
FROM user_activity_summary;
