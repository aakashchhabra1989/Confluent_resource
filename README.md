# Confluent Cloud Terraform Infrastructure

This project manages Confluent Cloud infrastructure using Terraform with a modular, multi-environment architecture supporting both non-production (dev, qa, uat) and production environments.

## 🏗️ Project Structure

```
confluent-resource-manager-aws\
├── main.tf                           # Root configuration (environment + module calls)
├── variables.tf                      # Root-level variables
├── outputs.tf                        # Root-level outputs
├── non-prod.tfvars                   # Non-production environment variables (dev, qa, uat)
├── prod.tfvars                       # Production environment variables
├── DEPLOYMENT_SUMMARY.md             # Complete deployment documentation
├── MULTI_ENVIRONMENT_SETUP.md        # Multi-environment setup guide
├── AWS/                              # AWS-specific resources module
│   ├── aws_cluster.tf                # AWS cluster, service accounts, API keys, ACLs
│   ├── outputs.tf                    # AWS module outputs
│   ├── sample_project_integration.tf # Sample project module integration
│   └── sample_project/               # Sample project Terraform module
│       ├── main.tf                   # Module configuration and locals
│       ├── variables.tf              # Module input variables
│       ├── outputs.tf                # Module outputs
│       ├── versions.tf               # Provider version requirements
│       ├── topics.tf                 # Kafka topics configuration
│       ├── schemas.tf                # Schema registry schemas
│       ├── http_source_connector.tf  # HTTP source connectors
│       ├── flink_create_table.tf     # Flink table creation
│       ├── flink_stream_processing.tf # Flink stream processing
│       ├── flink_advanced.tf         # Advanced Flink operations
│       ├── flink/                    # Flink SQL files directory
│       └── schemas/                  # Environment-specific schema files
│           ├── DEV/                  # Development schemas
│           ├── QA/                   # QA testing schemas
│           ├── UAT/                  # User acceptance testing schemas
│           └── PROD/                 # Production schemas
└── README.md                         # This file
```

## 🚀 Infrastructure Components

### Root Module
- **Environment Management**: Creates and manages Confluent Cloud environments
- **Module Orchestration**: Calls AWS module and integrates with project-specific modules

### AWS Module (`./AWS/`)
- **Kafka Cluster**: AWS Basic cluster with configurable region and availability
- **Service Accounts**: 
  - App manager service account for application operations
  - Admin manager service account for administrative tasks
- **API Keys**: 
  - Cloud API key for admin operations
  - Kafka-specific API keys for cluster operations
  - Schema Registry API keys
- **Access Control Lists (ACLs)**:
  - Cluster describe permissions
  - Topic create, read, write permissions
- **Flink Compute Pool**: For stream processing operations

### Sample Project Module (`./AWS/sample_project/`)
- **Topics**: Multi-environment Kafka topics with consistent naming
- **Schemas**: Avro schemas with environment-specific configurations
- **HTTP Source Connectors**: Data ingestion from HTTP endpoints
- **Flink Resources**: Stream processing tables and operations
- **Project Isolation**: Complete resource isolation per project

## 📋 Variables

### Root Variables
- `confluent_cloud_api_key`: Confluent Cloud API key
- `confluent_cloud_api_secret`: Confluent Cloud API secret
- `environment_id`: Environment ID for resource creation
- `environment_resource_name`: Resource name for the environment
- `environment_type`: Environment type (non-prod, prod)
- `sub_environments`: List of sub-environments (dev, qa, uat for non-prod; prod for production)
- `topic_base_prefix`: Base prefix for topic naming (`aws.myorg`)
- `aws_cluster_name`: Name for the AWS Kafka cluster
- `aws_cluster_region`: AWS region for cluster deployment
- `aws_cluster_cloud`: Cloud provider (AWS)
- `create_aws_dummy_topic`: Boolean to create example topics
- `default_topic_partition`: Number of partitions for topics

### Sample Project Module Variables
- Environment configuration (passed from parent modules)
- AWS cluster references (cluster ID, endpoints, API keys)
- Service account references
- Schema Registry configuration
- Flink compute pool reference

## 🔧 Usage

### Prerequisites
1. Terraform >= 1.0
2. Confluent Cloud account and API credentials
3. Appropriate cloud provider access (AWS)

### Configuration
1. Use the provided environment-specific variable files:
   - `non-prod.tfvars`: For dev, qa, uat environments
   - `prod.tfvars`: For production environment

2. Update the variables with your specific values if needed:
   ```hcl
   confluent_cloud_api_key    = "your-api-key"
   confluent_cloud_api_secret = "your-api-secret" 
   environment_type           = "non-prod"  # or "prod"
   sub_environments           = ["dev", "qa", "uat"]  # or ["prod"]
   # ... other variables
   ```

### Deployment

#### Multi-Environment Deployment
```bash
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Deploy Non-Production (dev, qa, uat)
terraform plan -var-file="non-prod.tfvars"
terraform apply -var-file="non-prod.tfvars"

# Deploy Production  
terraform plan -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars"
```

#### Environment Switching
```bash
# Switch from prod to non-prod
terraform apply -var-file="non-prod.tfvars"

# Switch from non-prod to prod
terraform apply -var-file="prod.tfvars"
```

### Cleanup
```bash
# Destroy non-prod environment
terraform destroy -var-file="non-prod.tfvars"

# Destroy prod environment  
terraform destroy -var-file="prod.tfvars"
```

## 📊 Outputs

The configuration provides comprehensive outputs including:
- Environment information (ID, name, type)
- Kafka cluster details (ID, endpoints, name)
- Service account information (IDs, names)
- API key references (sensitive)
- Schema Registry details
- Flink compute pool information
- HTTP Source Connector details (IDs, names per environment)
- Connection configuration for applications

## 🏷️ Resource Naming Convention

All resources follow the consistent naming pattern:
```
aws.myorg.{environment}.{project_name}.{resource_name}
```

### Examples:
- **Topics**: 
  - `aws.myorg.dev.sample_project.dummy_topic.0`
  - `aws.myorg.prod.sample_project.http_source_data.source-connector`
- **Schemas**: 
  - `aws.myorg.qa.sample_project.dummy_topic_with_schema-key`
  - `aws.myorg.prod.sample_project.dummy_topic_with_schema-value`
- **Connectors**: 
  - `HttpSourceConnector_aws-non-prod-cluster_dev_sample_project`
  - `HttpSourceConnector_aws-prod-cluster_prod_sample_project`

## 🔒 Security Notes

- API keys and secrets are marked as sensitive
- Service accounts follow principle of least privilege
- ACLs are configured for specific operations only
- Lifecycle protection enabled for critical resources

## 🌟 Key Features

- **Modular Architecture**: Clean separation between cloud providers and projects
- **Multi-Environment Support**: Complete support for dev, qa, uat, and prod environments
- **Scalable Design**: Easy to add new projects, environments, or cloud providers
- **Project Isolation**: Each project is a separate Terraform module
- **Environment Flexibility**: Easy switching between environments using tfvars files
- **Security First**: Proper ACL configuration and sensitive data handling
- **Consistent Naming**: Standardized naming convention across all resources
- **State Management**: Terraform state properly managed and tracked
- **Schema Versioning**: Environment-specific schema files and versions

## 🔄 Recent Changes

- **✅ Completed Modularization**: Transformed from monolithic to fully modular architecture
- **✅ Multi-Environment Support**: Implemented dev, qa, uat, and prod environment support
- **✅ Project Module Structure**: Created `sample_project` module with complete resource isolation
- **✅ Consistent Resource Naming**: Applied `aws.myorg.{environment}.{project_name}.{resource_name}` pattern
- **✅ Environment-Specific Schemas**: Organized schemas by environment (DEV/, QA/, UAT/, PROD/)
- **✅ HTTP Source Connectors**: Deployed multi-environment HTTP source connectors
- **✅ Flink Integration**: Added Flink compute pool and stream processing resources
- **✅ Production Deployment**: Successfully deployed both non-prod and prod environments
- **✅ Documentation Updates**: Comprehensive documentation with deployment summaries

## 🚧 Future Enhancements

- Additional project modules (e.g., `AWS/another_project/`)
- Azure module implementation in `./Azure/` folder
- CI/CD pipeline integration with environment promotion
- Enhanced monitoring and alerting setup
- Additional connector types (Sink connectors, Database connectors)
- Multi-region deployment support
- Advanced Flink stream processing patterns

## 📝 Configuration Files

- **Non-Production**: Use `non-prod.tfvars` for dev, qa, uat environments
- **Production**: Use `prod.tfvars` for production environment
- **Documentation**: 
  - `DEPLOYMENT_SUMMARY.md`: Complete deployment status and resource inventory
  - `MULTI_ENVIRONMENT_SETUP.md`: Detailed multi-environment setup guide

## 📈 Deployment Status

| Environment | Status | Topics | Schemas | Connectors | ACLs |
|-------------|---------|--------|---------|------------|------|
| dev         | ✅ Deployed | 3 | 2 | 1 | 2 |
| qa          | ✅ Deployed | 3 | 2 | 1 | 2 |
| uat         | ✅ Deployed | 3 | 2 | 1 | 2 |
| prod        | ✅ Deployed | 3 | 2 | 1 | 2 |
| **Total**   | **✅ Active** | **12** | **8** | **4** | **8** |

## 🆘 Troubleshooting

1. **State Issues**: Check `terraform.tfstate` and backup files
2. **Module Issues**: Run `terraform init` to reinstall modules
3. **Variable Issues**: Validate variable files match expected format
4. **Access Issues**: Verify Confluent Cloud API credentials
