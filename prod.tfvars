# Confluent Cloud API Credentials
# DO NOT use this for actual deployment - replace with real credentials
confluent_cloud_api_key = "your-api-key"
confluent_cloud_api_secret = "your-api-secret"

# Production Environment Configuration
environment_name = "prod-env"
environment_type = "prod"
sub_environments = ["prod"]
project_name = "sampleProject"
schema_base_path = "schemas"
topic_base_prefix = "aws.myorg"

aws_cluster_name = "aws-prod-cluster"
aws_cluster_region = "us-east-1"

# Topic Configuration for Production
create_aws_dummy_topic = true
default_topic_partition = 6

# Flink Configuration
flink_max_cfu = 10  # Higher capacity for production
enable_flink = true
