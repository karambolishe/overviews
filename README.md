The first Azure project using Terraform

Project name - OVERVIEWS

This project is prototype of initial startup that covers infrastructure for several environments with such Azure services:
    - Azure SQL server
    - Azure SQL
    - CosmosDB (SQL)
    - App Service
    - App insight
    - Key Vault with secrets belongs to services
    - Service principal (it must be created manually before terraform applying)
    - Storage account for App Service

The current configuration assumes two environments, but in case required have more then two, it can achieve by adding tfvars file and create additional remote state for them.
Initial steps.

Remote terraform state activation:
1. cd tf-state-dev && chmod +x script/tf_state_init.sh && ./script/tf_state_init.sh
2. terraform apply

Init main project:
1. cd infrastructure
2. terraform init -reconfigure -backend-config=storage_account_name=overviewstfdev \
                                -backend-config=container_name=overviews-dev \
                                -backend-config=key=terraform.tfstate \
                                -backend-config=access_key=${access key of storage account when placed remote terraform state}

Roll out infrastructure:
1. terraform plan -var-file=../dev.tfvars
2. terraform apply -auto-approve -var-file=../dev.tfvars
3. terraform show

