# Cluster-Only Deletion Commands

# Step 1: Remove lifecycle protection from dependent resources (if needed)
# Already done for cluster

# Step 2: Delete resources in dependency order

# Delete topics first (depend on cluster)
terraform destroy -target="module.aws_cluster.confluent_kafka_topic.aws_dummy_topic[0]"

# Delete ACLs (depend on cluster and API keys)
terraform destroy -target="module.aws_cluster.confluent_kafka_acl.app_manager_create_topics"
terraform destroy -target="module.aws_cluster.confluent_kafka_acl.app_manager_describe_cluster" 
terraform destroy -target="module.aws_cluster.confluent_kafka_acl.app_manager_read_topics"
terraform destroy -target="module.aws_cluster.confluent_kafka_acl.app_manager_write_topics"

# Delete cluster-specific API keys (depend on cluster)
terraform destroy -target="module.aws_cluster.confluent_api_key.admin_kafka_api_key"
terraform destroy -target="module.aws_cluster.confluent_api_key.app_manager_kafka_api_key"

# Finally delete the cluster itself
terraform destroy -target="module.aws_cluster.confluent_kafka_cluster.basic"

# What remains:
# - confluent_environment.sandbox (kept)
# - module.aws_cluster.confluent_service_account.admin_manager (kept)
# - module.aws_cluster.confluent_service_account.app_manager (kept)  
# - module.aws_cluster.confluent_api_key.admin_api_key (kept - cloud API key)
# - module.aws_cluster.confluent_role_binding.admin_environment_admin (kept)
