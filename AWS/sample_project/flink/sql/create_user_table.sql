-- Create User Profiles Table
-- This SQL creates a table from the Kafka topic with Avro schema
-- Template variables are substituted by Terraform

CREATE TABLE user_profiles (
  id STRING,
  username STRING,
  email STRING,
  registrationDate TIMESTAMP(3),
  WATERMARK FOR registrationDate AS registrationDate - INTERVAL '5' SECOND
) WITH (
  'connector' = 'confluent-kafka',
  'kafka.bootstrap.servers' = '${bootstrap_servers}',
  'value.format' = 'avro-confluent',
  'value.avro-confluent.url' = '${schema_registry_url}',
  'topic' = '${topic_name}'
);
