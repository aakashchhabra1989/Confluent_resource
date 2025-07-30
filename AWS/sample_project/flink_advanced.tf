# Advanced Flink SQL Statements
# This file references external SQL files for complex stream processing
# COMMENTED OUT: Getting 401 Unauthorized error - likely due to Flink service not fully enabled
# or missing specific Flink permissions in the Confluent Cloud environment

# Example: Create a sink table to write results back to Kafka
# resource "confluent_flink_statement" "create_result_sink" {
#   depends_on = [confluent_flink_statement.user_activity_stream]

#   organization {
#     id = data.confluent_organization.main.id
#   }

#   environment {
#     id = var.environment_id
#   }

#   compute_pool {
#     id = confluent_flink_compute_pool.main.id
#   }

#   principal {
#     id = confluent_service_account.admin_manager.id
#   }

#   # Reference external SQL file with variable substitution
#   statement = templatefile("${path.module}/flink/sql/create_sink_table.sql", {
#     bootstrap_servers = confluent_kafka_cluster.basic.bootstrap_endpoint
#   })

#   properties = {
#     "sql.current-catalog"  = var.environment_id
#     "sql.current-database" = confluent_kafka_cluster.basic.id
#   }

#   rest_endpoint = "https://flink.${var.aws_cluster_region}.${lower(var.aws_cluster_cloud)}.confluent.cloud"

#   credentials {
#     key    = confluent_api_key.admin_api_key.id
#     secret = confluent_api_key.admin_api_key.secret
#   }

#   lifecycle {
#     prevent_destroy = true
#   }
# }

# Example: Insert query to populate the sink table
# resource "confluent_flink_statement" "populate_sink" {
#   depends_on = [confluent_flink_statement.create_result_sink]

#   organization {
#     id = data.confluent_organization.main.id
#   }

#   environment {
#     id = var.environment_id
#   }

#   compute_pool {
#     id = confluent_flink_compute_pool.main.id
#   }

#   principal {
#     id = confluent_service_account.admin_manager.id
#   }

#   # Reference external SQL file
#   statement = file("${path.module}/flink/sql/populate_sink.sql")

#   properties = {
#     "sql.current-catalog"  = var.environment_id
#     "sql.current-database" = confluent_kafka_cluster.basic.id
#   }

#   rest_endpoint = "https://flink.${var.aws_cluster_region}.${lower(var.aws_cluster_cloud)}.confluent.cloud"

#   credentials {
#     key    = confluent_api_key.admin_api_key.id
#     secret = confluent_api_key.admin_api_key.secret
#   }

#   lifecycle {
#     prevent_destroy = true
#   }
# }
