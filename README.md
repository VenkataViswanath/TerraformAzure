# How To use this project as your starter template.
This repository showcases the power of Terraform through sample Azure deployments.
For more details on IaC, you can go through this medium article: https://medium.com/@cvviswa7/the-power-of-infrastructure-as-code-iac-ab46d0943544

To use this project for your learning, follow the below steps:
1. Clone the project in your local repository.
2. Make sure that you have terraform installed and setup in your local environment.
3. Define environment variables for authenticating to Azure using a service principal by following the below mentioned steps:
   https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build
  
4. Open a terminal and initiate the provider and module setup through "terraform init" command.
5. Then run "terraform validate" to ensure that the code is syntactically correct.
6. Run "terraform fmt" to maintain clear and uniform formatting of your terraform configuration files.
7. Run "terraform plan" to view the execution plan.
8. Now run "terraform apply" to run the execution plan. The plan while performing apply operation might be different from that of "terraform plan". To use the same plan utilize the "-out" parameter along with terraform plan command and specify a file name where the plan output should be stored. Ex: terraform plan -out "myplan.txt". Now when executing apply, you can specify terraform to explicitly use this plan.
terraform apply -out=myplan.tfplan

9. You can now find a terraform.tfstate file automatically created in your directory. This file acts as "single source of truth" and terraform maintains and manages this file to handle your infrastructure.
10. Run "terraform destory" to destroy all the resources. Note that terraform only manages the resources that are defined through terraform configuration. The resources created outside of terraform are not managed by terraform and hence are not deleted by the destroy command.

11. I have also created a separate folder named variable_validation. This folder has some details on how you can use different variables and how you can enforce some validation conditions on them. Feel free to play around with this. You just need to change your current working directory to variable_validation, and then run the "terraform apply" command, and pass different inputs to variables to see the outputs based on the validation conditions.

# Learning Outcomes
## Blocks: 
1. terraform block
2. provider block
3. resource block
4. variables block
5. locals block
6. data block
7. module block
8. output block
9. dynamic block

## Others:
1. terraform comments
2. terraform state - local backend and remote backend
3. handling sensitive data in terraform
4. Variable Validation
5. for_each statement

# Handy Terraform Commands
1. terraform init: Initializes a Terraform working directory by downloading and installing any necessary plugins.
2. terraform plan: Generates an execution plan showing what actions Terraform will take to change the infrastructure as defined in your configuration files.
3. terraform apply: Applies the changes required to reach the desired state of the configuration, as defined by your Terraform files.
4. terraform destroy: Destroys all the resources defined in your Terraform configuration, effectively removing the infrastructure.
5. terraform validate: Checks the syntax and validity of your Terraform configuration files.
6. terraform refresh: Updates the state file against real-world resources. It does not modify resources, but it does update the state file with the latest status.
7. terraform state: Allows you to perform operations on Terraform state such as listing resources, moving resources to a different state file, etc.
8. terraform output: Prints the outputs defined in your Terraform configuration, such as IP addresses, resource IDs, etc.
9. terraform graph: Generates a visual representation of the dependency graph of your Terraform resources.
10. terraform fmt: Rewrites Terraform configuration files in a canonical format and style.

### Terraform Tutorials Documentation: https://developer.hashicorp.com/terraform/tutorials
