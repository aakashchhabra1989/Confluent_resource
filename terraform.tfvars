# Example terraform.tfvars file
# Copy this file to terraform.tfvars and fill in your actual values

# Confluent Cloud API Credentials
# You can get these from the Confluent Cloud Console -> Cloud API Keys
confluent_cloud_api_key    = "EM73E7VI53E4QDT2"
confluent_cloud_api_secret = "d094RC2JG5VuAoQEqVJoQ1ds+5GX8Df8r71xFmpbvRQEw2MobmBIAOZW04c3+WPX"

environment_name = "sandbox-env"
environment_type = "sandbox"
sub_environments = ["sandbox"]
project_name = "sample_project"
schema_base_path = "schemas"
topic_base_prefix = "aws.myorg"

aws_cluster_name = "aws-sandbox-cluster"
aws_cluster_region = "us-east-1"

# Topic Configuration for Sandbox
create_aws_dummy_topic = true
default_topic_partition = 3

# Flink Configuration
flink_max_cfu = 5  # Higher capacity for production
enable_flink = true
