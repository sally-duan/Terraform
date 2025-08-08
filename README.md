	1. add terraform
	2. Add terraform on windows
	--install thru powershell the chocolate:Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
	3. Choco install terraform and click yes
	4. Terraform version verification ( after installation, in powershell run that)
	5. Set up aws account. Create a IAM user. (programmatic access). Attach existing policy directly as Admin access.
	6. Pay attention to my region otherwise those resource does not show
	7. Add different permissions thru group access policy with admin permission for example ec2 o vpc etc
	8. Must have a main.tf and run below command
  Terraform init
  terraform plan
  terraform apply
  terraform destroy
