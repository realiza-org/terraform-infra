init:
	terraform init

fmt:
	terraform fmt

validate:
	terraform validate

plan:
	terraform plan

apply:
	terraform apply -auto-approve

state:
	terraform state list

destroy:
	terraform destroy -auto-approve

output:
	terraform output