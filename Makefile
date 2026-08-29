.PHONY: plan apply destroy

plan:
	aws-vault exec --no-session valheim -- terraform plan

apply:
	aws-vault exec --no-session valheim -- terraform apply

destroy:
	aws-vault exec --no-session valheim -- terraform destroy