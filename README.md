terraform apply -var-file=env/dev/variables.tfvars -var-file=shared.tfvars

terraform init -backend-config=env/dev/backend.conf