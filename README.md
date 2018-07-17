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
- [x] RDS Helm variable(API)
- [x] Terraform State S3 and Locking DynamoDB
- [ ] new Readme.md

##### Run Vagrant devops-box

```bash
$ vagrant up && vagrant ssh
```

##### Configure AWS cli

```bash
#configure awscli
$ aws configure

```

##### Run Terraform

```bash

$ cd /vagrant

# Download and install modules for the configuration
$ terraform init

# Create infrastructure
$ terraform plan -out=apply.me -lock=false
$ terraform apply -lock=false apply.me
```

##### Prepare environments and import applications

```bash
# Configure token
$ bash -c "$(terraform output -module=jx token)"

# create environments
$ bash -c "$(terraform output -module=jx env_development)"
$ bash -c "$(terraform output -module=jx env_staging)"
$ bash -c "$(terraform output -module=jx env_production)"

# Import applications
$ bash -c "$(terraform output -module=jx_app_api import_app)"
$ bash -c "$(terraform output -module=jx_app_web import_app)"
```


##### Demo - Creating a New Feature

```bash


# STEP 1 XXXXXXXXXXXXXXXXXXXXXXXXXX  DEVELOPER

# Clone appp repo
$ $ git clone https://github.com/xxxxx/web.git
$ cd web

# create an issue
$ jx create issue -t 'feature version'

# create new branch for PR
$ git checkout -b feature_version

# code a feature
$ vi routes/index.js

# push file and connect commit with issue #1
$ git add routes/index.js
$ git commit -m 'add feature ver -  fixes #1'
$ git push origin feature_version

# Create PR with hub or manually in Github page
$ hub pull-request

# STEP 2 XXXXXXXXXXXXXXXXXXXXXXXXXX PRODUCT OWNER (or similar)

Automatically is created a pipeline for this PR and preview environment

Product Owner aprove PR or no

If Yes -> new release will be automatically created

If no  -> finish process

# STEP 3 XXXXXXXXXXXXXXXXXXXXXXXXXX DEPLOY RELEASE

# Promote release in Product environment (rolout)
$ jx promote --app='web' --version='0.0.10' --env='production' --batch-mode=true

# Rollback version
$ jx promote --app='web' --version='0.0.9' --env='production' --batch-mode=true


```

##### Delete infra

```bash
# Step 1
$ terraform destroy -target=null_resource.jx_installation --force

# Step 2
$ terraform destroy --force -lock=false
```