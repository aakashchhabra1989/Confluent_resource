# Example terraform.tfvars file
# Copy this file to terraform.tfvars and fill in your actual values

# Confluent Cloud API Credentials
# You can get these from the Confluent Cloud Console -> Cloud API Keys
confluent_cloud_api_key = "your-api-key"
confluent_cloud_api_secret = "your-api-secret"

environment_name = "sandbox-env"
environment_type = "sandbox"
sub_environments = ["sandbox"]
project_name = "sampleProject"
schema_base_path = "schemas"
topic_base_prefix = "aws.myorg"

aws_cluster_name = "aws-sandbox-cluster"
aws_cluster_region = "us-east-1"

# Topic Configuration for Sandbox
create_aws_dummy_topic = true
default_topic_partition = 6

# Flink Configuration
flink_max_cfu = 5  # Higher capacity for production
enable_flink = true
