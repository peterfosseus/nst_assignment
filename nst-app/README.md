# Rewards API slice

A deliberately small, dependency-free implementation of the assignment's public
health endpoint. The application listens on port `8080`; the AWS Application Load
Balancer should expose `/health` publicly and target this port in the protected
subnet.

## Run locally

Bash:

```bash
python app.py
```

Then request `http://localhost:8080/health`. Run tests with:



# nst-aws-tf

## Name
NST Rewards Python App

## Description
This project contains the source code for the Senior Cloud engineer - Technical Vetting Assignment.
It is used to deploy the Rewards Python App.

## Prerequisites
Ensure that you have created the require S3 Terraform State bucket : nst-rewards-dev-terraform-state
Ensure that you have created the required AWS infrastructure : nst-aws-tf
Create the AWS OIDC connection between GitLab and the AWS account

## Visuals
Directory structure, generated with "$ tree -a -I '.git|.idea' -d"
```text
.
└── scripts
```
- Simple python application

## Installation
Configure the OIDC connection to dev and prd accounts/environments (if you have not already)
- Log into AWS console
- Select IAM -> Identity Provider -> Add provider (Create Identity Provider)
- Provider type: "OpenID Connect"
- Provider URL : https://gitlab.com
- Audience: https://gitlab.com
- Tag | Name | GitLab OIDC

Select "Assign role" (from the green status bar at the top of the screen)

- Select Create Role/Assign role (top right hand corner)
- Create a new role
- Web Identity
- identity provider | gitlab.com
- Audience          | https://gitlab.com
- Group: <the name od your GitLab group or username>
- Project: *
- Workspace : *
- Run Phase : *

Add Premissions:
- [*] Administrator Access
- Role name: gitlab_oidc_role
- Adjust the example section below to restrict the project access

```text
"StringLike": {
   "gitlab.com:sub": [
      "project_path:peter.fosseus/*:ref_type:*:ref:*",
      "project_path:peter.fosseus/*:ref_type:*:ref:*"
   ]
}
```

When you are complete copy the ARN of the newly created role.
- Example: arn:aws:iam::<aws account id>:role/terraform_cloud_oidc_role

Create GitLab CI/CD variables for both accounts/environments:
- Settings -> CI/CD -> Variables
```
AWS_DEFAULT_REGION = eu-west-1
DEV_AWS_ROLE_ARN = arn:aws:iam::1234567890123:role/gitlab_oidc_role
DEV_CODEDEPLOY_APPLICATION = nst-rewards-dev-application
DEV_CODEDEPLOY_DEPLOYMENT_GROUP = nst-rewards-dev-deployment-group
DEV_DEPLOY_BUCKET = nst-rewards-dev-code
---
PRD_AWS_ROLE_ARN = arn:aws:iam::1234567890123:role/gitlab_oidc_role
PRD_CODEDEPLOY_APPLICATION = nst-rewards-prd-application
PRD_CODEDEPLOY_DEPLOYMENT_GROUP = nst-rewards-prd-deployment-group
PRD_DEPLOY_BUCKET = nst-rewards-prd-code
```
## Usage
The pipeline is configured to work as follows:
- Create a dev and prd branch
- When working in either dev
- - When you commit your changes the pipeline will run and deploy the app
- Once you are happy with plan:
- - create a MR to master
- - the pipeline will then wait/manual for you to deploy to production.

## Author
Peter Fosseus - 2026-08-16