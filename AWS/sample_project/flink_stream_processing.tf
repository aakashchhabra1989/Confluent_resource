# User Activity Stream - Flink SQL Statement
# This file references external SQL file for better maintainability
# COMMENTED OUT: Getting 401 Unauthorized error - likely due to Flink service not fully enabled
# or missing specific Flink permissions in the Confluent Cloud environment

# resource "confluent_flink_statement" "user_activity_stream" {
#   depends_on = [confluent_flink_statement.create_user_table]

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
#   statement = file("${path.module}/flink/sql/user_activity_stream.sql")

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
