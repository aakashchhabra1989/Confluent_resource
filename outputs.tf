# Environment Outputs
output "environment_id" {
  description = "The ID of the Confluent Environment"
  value       = confluent_environment.main.id
}

output "environment_name" {
  description = "The name of the Confluent Environment"
  value       = confluent_environment.main.display_name
}

# Kafka Cluster Outputs
output "kafka_cluster_id" {
  description = "The ID of the Kafka cluster"
  value       = module.aws_cluster.kafka_cluster_id
}

output "kafka_cluster_name" {
  description = "The name of the Kafka cluster"
  value       = module.aws_cluster.kafka_cluster_name
}

output "kafka_cluster_bootstrap_endpoint" {
  description = "The bootstrap endpoint of the Kafka cluster"
  value       = module.aws_cluster.kafka_cluster_bootstrap_endpoint
}

output "kafka_cluster_rest_endpoint" {
  description = "The REST endpoint of the Kafka cluster"
  value       = module.aws_cluster.kafka_cluster_rest_endpoint
}

# Service Account Outputs
output "service_account_id" {
  description = "The ID of the service account"
  value       = module.aws_cluster.service_account_id
}

output "service_account_name" {
  description = "The name of the service account"
  value       = module.aws_cluster.service_account_name
}

# Admin Service Account Outputs
output "admin_service_account_id" {
  description = "The ID of the admin service account"
  value       = module.aws_cluster.admin_service_account_id
}

output "admin_service_account_name" {
  description = "The name of the admin service account"
  value       = module.aws_cluster.admin_service_account_name
}

# API Key Outputs
output "kafka_api_key_id" {
  description = "The ID of the Kafka API key"
  value       = module.aws_cluster.kafka_api_key_id
  sensitive   = true
}

output "kafka_api_key_secret" {
  description = "The secret of the Kafka API key"
  value       = module.aws_cluster.kafka_api_key_secret
  sensitive   = true
}

# Admin API Key Outputs
output "admin_api_key_id" {
  description = "The ID of the Admin Cloud API key"
  value       = module.aws_cluster.admin_api_key_id
  sensitive   = true
}

output "admin_api_key_secret" {
  description = "The secret of the Admin Cloud API key"
  value       = module.aws_cluster.admin_api_key_secret
  sensitive   = true
}

# Admin Kafka API Key Outputs  
output "admin_kafka_api_key_id" {
  description = "The ID of the Admin Kafka API key"
  value       = module.aws_cluster.admin_kafka_api_key_id
  sensitive   = true
}

output "admin_kafka_api_key_secret" {
  description = "The secret of the Admin Kafka API key"
  value       = module.aws_cluster.admin_kafka_api_key_secret
  sensitive   = true
}

# Topic Outputs - temporarily disabled until sample_project resources are working
# output "aws_dummy_topic_names" {
#   description = "The names of the AWS dummy topics (if created)"
#   value       = module.aws_cluster.aws_dummy_topic_names
# }

# output "aws_dummy_topic_with_schema_names" {
#   description = "The names of the AWS dummy topics with schema"
#   value       = module.aws_cluster.aws_dummy_topic_with_schema_names
# }

# output "aws_dummy_topic_key_schema_ids" {
#   description = "The IDs of the key schemas for AWS dummy topics with schema"
#   value       = module.aws_cluster.aws_dummy_topic_key_schema_ids
# }

# output "aws_dummy_topic_value_schema_ids" {
#   description = "The IDs of the value schemas for AWS dummy topics with schema"
#   value       = module.aws_cluster.aws_dummy_topic_value_schema_ids
# }

# output "aws_dummy_topic_key_schema_versions" {
#   description = "The versions of the key schemas"
#   value       = module.aws_cluster.aws_dummy_topic_key_schema_versions
# }

# output "aws_dummy_topic_value_schema_versions" {
#   description = "The versions of the value schemas"
#   value       = module.aws_cluster.aws_dummy_topic_value_schema_versions
# }

# Connection Information
output "connection_config" {
  description = "Connection configuration for Kafka clients"
  value = {
    bootstrap_servers = module.aws_cluster.kafka_cluster_bootstrap_endpoint
    api_key           = module.aws_cluster.kafka_api_key_id
    api_secret        = module.aws_cluster.kafka_api_key_secret
  }
  sensitive = true
}

# Schema Registry Outputs
output "schema_registry_cluster_id" {
  description = "The ID of the Schema Registry cluster"
  value       = module.aws_cluster.schema_registry_cluster_id
}

output "schema_registry_rest_endpoint" {
  description = "The REST endpoint of the Schema Registry cluster"
  value       = module.aws_cluster.schema_registry_rest_endpoint
}

output "schema_registry_api_key_id" {
  description = "The ID of the Schema Registry API key"
  value       = module.aws_cluster.schema_registry_api_key_id
}

output "schema_registry_api_key_secret" {
  description = "The secret of the Schema Registry API key"
  value       = module.aws_cluster.schema_registry_api_key_secret
  sensitive   = true
}

# Flink/Tableflow Outputs
output "flink_compute_pool_id" {
  description = "The ID of the Flink compute pool"
  value       = module.aws_cluster.flink_compute_pool_id
}

# HTTP Source Connector Outputs
# output "http_source_topic_names" {
#   description = "The names of the HTTP source topics"
#   value       = module.aws_cluster.http_source_topic_names
# }

output "http_source_connector_ids" {
  description = "The IDs of the HTTP source connectors"
  value       = module.aws_cluster.http_source_connector_ids
}

output "http_source_connector_names" {
  description = "The names of the HTTP source connectors"
  value       = module.aws_cluster.http_source_connector_names
}
