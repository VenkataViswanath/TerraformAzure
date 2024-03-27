# TerraformAzureDemonstration
This repository showcases the power of Terraform through sample Azure deployments.

To use this project for your learning, follow the below steps:
1. Clone the project in your local repository.
2. Make sure that you have terraform installed and setup in your local environment.
3. Define environment variables for authenticating to Azure using a service principal by following the below mentioned steps:
   https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build
  
4. Open a terminal and initiate the provider setup through "terraform init" command.
5. Then run "terraform validate" to ensure that the code is syntactically correct.
6. Run "terraform fmt" to maintain clear and uniform formatting of your terraform configuration files.
7. Run "terraform plan" to view the execution plan.
8. Now run "terraform apply" to run the execution plan. The plan while performing apply operation might be different from that of "terraform plan". To use the same plan utilize the "-out" parameter along with terraform plan command and specify a file name where the plan output should be stored. Ex: terraform plan -out "myplan.txt". Now when executing apply, you can specify terraform to explicitly use this plan.
terraform apply -out=myplan.tfplan

9. You can now find a terraform.tfstate file automatically created in your directory. This file acts as "single source of truth" and terraform maintains and manages this file to handle your infrastructure.
10. Run "terraform destory" to destroy all the resources. Note that terraform only manages the resources that are defined through terraform configuration. The resources created outside of terraform are not managed by terraform and hence are not deleted by the destroy command.
