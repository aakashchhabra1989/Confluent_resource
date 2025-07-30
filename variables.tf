# Confluent Cloud API Credentials
variable "confluent_cloud_api_key" {
  description = "Confluent Cloud API Key"
  type        = string
  sensitive   = true
}

variable "confluent_cloud_api_secret" {
  description = "Confluent Cloud API Secret"
  type        = string
  sensitive   = true
}

# Environment Configuration
variable "environment_name" {
  description = "Name for the Confluent Environment"
  type        = string
  default     = "terraform-env"
}

variable "environment_type" {
  description = "Environment type (non-prod, prod)"
  type        = string
  default     = "non-prod"
  validation {
    condition     = contains(["non-prod", "prod"], var.environment_type)
    error_message = "Environment type must be either 'non-prod' or 'prod'."
  }
}

variable "sub_environments" {
  description = "List of sub-environments to create resources for"
  type        = list(string)
  default     = ["dev"]
  validation {
    condition = alltrue([
      for env in var.sub_environments : contains(["dev", "qa", "uat", "prod"], env)
    ])
    error_message = "Sub-environments must be from: dev, qa, uat, prod."
  }
}

variable "project_name" {
  description = "Project name to be included in resource naming"
  type        = string
  default     = "sampleProject"
}

variable "schema_base_path" {
  description = "Base path for schema files"
  type        = string
  default     = "schemas"
}

variable "topic_base_prefix" {
  description = "Base prefix for topic names"
  type        = string
  default     = "aws.sampleproject"
}

# Kafka Cluster Configuration
variable "aws_cluster_name" {
  description = "Name for the Kafka cluster"
  type        = string
  default     = "terraform-cluster"
}

variable "aws_cluster_availability" {
  description = "The availability zone configuration of the Kafka cluster"
  type        = string
  default     = "SINGLE_ZONE"
  validation {
    condition     = contains(["SINGLE_ZONE", "MULTI_ZONE"], var.aws_cluster_availability)
    error_message = "Availability must be either 'SINGLE_ZONE' or 'MULTI_ZONE'."
  }
}

variable "aws_cluster_cloud" {
  description = "The cloud service provider where the Kafka cluster will be created"
  type        = string
  default     = "AWS"
  validation {
    condition     = contains(["AWS", "GCP", "AZURE"], var.aws_cluster_cloud)
    error_message = "Cloud must be one of 'AWS', 'GCP', or 'AZURE'."
  }
}

variable "aws_cluster_region" {
  description = "The cloud service provider region where the Kafka cluster will be created"
  type        = string
  default     = "us-east-1"
}

# Topic Configuration
variable "create_aws_dummy_topic" {
  description = "Whether to create an example Kafka topic"
  type        = bool
  default     = true
}

variable "default_topic_partition" {
  description = "Number of partitions for the example topic"
  type        = number
  default     = 3
  validation {
    condition     = var.default_topic_partition > 0
    error_message = "Topic partitions must be greater than 0."
  }
}

# Flink/Tableflow Configuration
variable "flink_max_cfu" {
  description = "Maximum Confluent Flink Units for the compute pool"
  type        = number
  default     = 5
}

variable "enable_flink" {
  description = "Enable Flink compute pool for Tableflow"
  type        = bool
  default     = true
}
