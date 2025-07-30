-- Create Sink Table for Results
-- This SQL creates a sink table to write processed results back to Kafka

CREATE TABLE user_activity_sink (
  username STRING,
  activity_count BIGINT,
  window_start TIMESTAMP(3),
  window_end TIMESTAMP(3)
) WITH (
  'connector' = 'confluent-kafka',
  'kafka.bootstrap.servers' = '${bootstrap_servers}',
  'topic' = 'user-activity-results',
  'value.format' = 'json'
);
