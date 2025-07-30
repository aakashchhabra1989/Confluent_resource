# Confluent Cloud Infrastructure Configuration
# This file contains core infrastructure resources: environments
# For AWS cluster and topic definitions, see AWS/ module

terraform {
  required_version = ">= 1.0"
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "~> 1.0"
    }
  }
}

# Configure the Confluent Provider
provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}

# Create a Confluent Cloud Environment
resource "confluent_environment" "main" {
  display_name = var.environment_name

  # Temporarily commenting out prevent_destroy to allow environment recreation
  # lifecycle {
  #   prevent_destroy = true
  # }
}

# AWS Cluster and Topics Module
module "aws_cluster" {
  source = "./AWS"

  # Environment variables
  environment_id            = confluent_environment.main.id
  environment_resource_name = confluent_environment.main.resource_name
  environment_type          = var.environment_type
  sub_environments          = var.sub_environments
  project_name              = var.project_name
  schema_base_path          = var.schema_base_path
  topic_base_prefix         = var.topic_base_prefix

  # AWS cluster variables
  aws_cluster_name         = var.aws_cluster_name
  aws_cluster_availability = var.aws_cluster_availability
  aws_cluster_cloud        = var.aws_cluster_cloud
  aws_cluster_region       = var.aws_cluster_region

  # Topic variables  
  create_aws_dummy_topic   = var.create_aws_dummy_topic
  default_topic_partition  = var.default_topic_partition

  # Flink/Tableflow variables
  flink_max_cfu = var.flink_max_cfu
  enable_flink  = var.enable_flink
}
