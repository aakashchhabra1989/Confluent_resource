# Sample Project Module Outputs

# HTTP Source Connector Outputs (these should be working)
output "http_source_connector_ids" {
  description = "The IDs of the HTTP source connectors"
  value       = { for env, connector in confluent_connector.http_source : env => connector.id }
}

output "http_source_connector_names" {
  description = "The names of the HTTP source connectors"
  value       = { for env in var.sub_environments : env => "HttpSourceConnector_${var.aws_cluster_name}_${env}_${local.project_name}" }
}

# Flink Outputs (these should be working)
output "flink_compute_pool_id" {
  description = "The ID of the Flink compute pool"
  value       = var.flink_compute_pool_id
}

output "organization_id" {
  description = "The ID of the organization"
  value       = var.organization_id
}
