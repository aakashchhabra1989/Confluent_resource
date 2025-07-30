# Sandbox Environment Configuration
# DO NOT use this for actual deployment - replace with real credentials

confluent_cloud_api_key = "your-api-key"
confluent_cloud_api_secret = "your-api-secret"

# Environment Configuration
environment_name = "sandbox-env"
environment_type = "sandbox"
sub_environments = ["sandbox"]
project_name = "sampleProject"
schema_base_path = "schemas"
topic_base_prefix = "aws.myorg"

aws_cluster_name         = "aws-sandbox-cluster"
aws_cluster_availability = "SINGLE_ZONE"
aws_cluster_cloud        = "AWS"
aws_cluster_region       = "us-east-1"

create_aws_dummy_topic     = true
default_topic_partition = 6

# Flink/Tableflow Configuration
flink_max_cfu = 5
enable_flink  = true
