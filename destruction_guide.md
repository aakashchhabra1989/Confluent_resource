# Terraform Destruction Guide

## Current Protected Resources:
- Environment: confluent_environment.sandbox
- Kafka Cluster: module.aws_cluster.confluent_kafka_cluster.basic
- Service Accounts: admin_manager, app_manager
- API Keys: admin_api_key, admin_kafka_api_key, app_manager_kafka_api_key
- ACLs: All app_manager ACLs
- Topic: aws_dummy_topic

## Destruction Options:

### Option 1: Complete Destruction (Recommended)
```powershell
# Step 1: Remove lifecycle protection (modify files)
# Step 2: Plan destruction
terraform plan -destroy

# Step 3: Execute destruction
terraform destroy

# Step 4: Clean up state files
Remove-Item terraform.tfstate*
```

### Option 2: Selective Destruction
```powershell
# Destroy only specific resources
terraform destroy -target=module.aws_cluster.confluent_kafka_topic.aws_dummy_topic[0]
terraform destroy -target=module.aws_cluster.confluent_kafka_cluster.basic
terraform destroy -target=confluent_environment.sandbox
```

### Option 3: Force Destruction (Use with caution)
```powershell
# Remove from state without destroying (if resources already deleted manually)
terraform state rm confluent_environment.sandbox
terraform state rm module.aws_cluster.confluent_kafka_cluster.basic
# ... etc for each resource
```

### Option 4: Manual Cleanup
1. Delete resources manually in Confluent Cloud Console
2. Remove from Terraform state: `terraform state rm <resource_name>`
3. Clean up state files

## Cost Impact:
- Kafka Cluster: Stops billing immediately
- Topics: No separate billing (included with cluster)
- Service Accounts/API Keys: No cost
- Environment: No cost (container only)

## Data Impact:
⚠️ WARNING: All data in topics will be permanently lost!
⚠️ WARNING: All configurations will be permanently deleted!

## Recovery:
- Requires complete re-deployment
- Data cannot be recovered
- API keys will be regenerated (update applications)
