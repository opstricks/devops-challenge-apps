# DevOps Challenge

**Status:** under development

Todo:
- [x] VPC
- [x] EKS Module
- [x] EKS Storage
- [x] EKS Dashboard / EKS Heapster
- [x] ECR - Container Registry
- [x] Jenkins-x Module
- [x] Jenkins-x Apps Module
- [x] Heml Charts    API / WEB
- [x] Skafold config API / WEB
- [x] RDS
- [ ] RDS Helm variable(API)
- [ ] new Readme.md


##### Run Vagrant devops-box

```bash

$ vagrant up && vagrant ssh
```

##### Configure AWS cli

```bash
$ aws configure
AWS Access Key ID [None]: AKIAJJ.........UWDQ
AWS Secret Access Key [None]: 8cwF+TY7M..............vuyox7kU
Default region name [None]: us-east-1
Default output format [None]: json
```

##### Create Terraform

```bash

$ cd /vagrant

# Download and install modules for the configuration
$ terraform get -update && terraform init

# Create infrastructure
$ terraform plan -out=apply.me  &&  terraform apply apply.me

# provisional database
$ kubectl apply -f db_provisorio/dev/

```

##### Prepare GitOps

```bash
# Configure token
bash -c "$(terraform output -module=jx token)"

# create environments
$ bash -c "$(terraform output -module=jx env_dev)"
$ bash -c "$(terraform output -module=jx env_staging)"
$ bash -c "$(terraform output -module=jx env_production)"

# Import applications
$ bash -c "$(terraform output -module=jx_app_api import_app)"
$ bash -c "$(terraform output -module=jx_app_web import_app)"
```

##### Delete infra


```bash

# Step 1
$ terraform destroy -target=null_resource.jx_install --force

# Step 2
Delete all ELBs

# Step 3
$ terraform destroy --force
```