# nst-tf-bootstrap

## Name
NST Rewards Terraform State S3 Bucket Scripts

## Description
- This project contains the source code for the Senior Cloud engineer - Technical Vetting Assignment.
- It is used to create the Rewards Terraform State S3 Bucket Scripts

## Prerequisites
AWS OIDC connection between GitLab and the AWS account

## Visuals
Directory structure, generated with "$ tree -a -I '.git|.idea' -d"
```text
.
└── terraform
    ├── environments
    │   ├── dev
    │   └── prd
    └── modules
```
Terraform code is created as modules in the modules folder
dev and prd call the module passing environment specific settings
example: dev has single az RDS, prd have multi-az RDS, both call the same module.

## Installation
Configure the OIDC connection to dev and prd accounts/environments (if you have not already)
Log into AWS console
Select IAM -> Identity Provider -> Add provider (Create Identity Provider)
```
    Provider type: "OpenID Connect"
    Provider URL : https://gitlab.com
    Audience: https://gitlab.com
    Tag | Name | GitLab OIDC
```
Select "Assign role" (from the green status bar at the top of the screen)

Select Create Role/Assign role (top right hand corner)
```
   Create a new role
   Web Identity
   identity provider | gitlab.com
   Audience          | https://gitlab.com
   Group: <the name od your GitLab group or username>
   Project: *
   Workspace : *
   Run Phase : *
```
```
Add Premissions:
[*] Administrator Access
Role name: gitlab_oidc_role
```
Adjust the example section below to restrict the project access

```yaml
"StringLike": {
    "gitlab.com:sub": [
        "project_path:peter.fosseus/*:ref_type:*:ref:*",
        "project_path:peter.fosseus/*:ref_type:*:ref:*"
    ]
}
```

When you are complete copy the ARN of the newly created role.
- Example: arn:aws:iam::<aws account id>:role/terraform_cloud_oidc_role

Create GitLab CI/CD variables for both accounts/environments
Settings -> CI/CD -> Variables
```commandline
AWS_DEFAULT_REGION = eu-west-1
DEV_AWS_ROLE_ARN   = arn:aws:iam::1234567890123:role/gitlab_oidc_role
PRD_AWS_ROLE_ARN   = arn:aws:iam::1234567890123:role/gitlab_oidc_role
```
## Usage
The pipeline is configured to work as follows:
- Create a dev and prd branch
- When working in either dev or prod branch
- - When you commit your changes the pipeline will run to the end of the planning stage and stop.
- Once you are happy with plan:
- - create a MR to master
- - the pipeline will enable the apply and destroy stages

## Author
Peter Fosseus - 2026-08-16
