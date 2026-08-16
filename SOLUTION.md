
# Decisions made during the project.

## IDE 
- InteliJ IDEA
- - I like the Git integration 
- - Installing Terrafom HCP plugin gives syntax, autocomplete and help.

## CI/CD
- GitLab: I'm more familiar with it and I like the visual pipeline element.

## Overview of high level project decisions  
- Split task into 3 separate GitLab projects
- - bootstrap to bring up the S3 state bucket
- - infrastructure to bring the environment up
- - app to deploy the application
- Allows work to be divided to teams, different access levels
- Separation of responsibilities
- Developers are not exposed to Infrastructure code

## AWS 
### Architecture
- ALB -> Target Group -> ASG -> Code Deploy (hook)
- - allows instance to scale, load balancing, auto deploy the application on a scalling event
- EC2 is in its own private subnet no access from the outside
- - very secure, instance has no key pair, and no ssh access, access is through SSM
### Ansible
- Systems Manger : AWS-ApplyAnsiblePlaybooks
- - Instance is accessed through SSM, AWS unstalls the dependencies, visual confirmation and debugging)
### Code Deploy
- Easy deploy to EC2

## GIT
- Decided on a two branch (dev/prd) and main strtegy
- - Working and commiting in dev/prd branches runs the pipeline to the plan stage and stops
- - Once the changes are merged to main the pipeline is now manually triggerd and manually applied.
  

## Terraform
- Always check for latest stable versions as base, keeps code ahead of any deprications
- Use external modules to speed up deployment
- Make internal modules and put them in /modules folder
- Separate sevices into logical files with their own variables, makes it easy to find the files
- Call the module from the dev/prd, reduces duplication of code ans associated issues.
### Backend
- Use the http to create the S3 bucket for the main terraform 
- Use the S3 bucket for the Terraform state, both options work well, 
- I found I could use the CLI with the S3 option with AWS credentials
- It looks like you can do the same with the http option with GitLab credentials

Thank you for the challenge, there are improvements I would like make but at some point one just needs to submit.

Kind Regards
Peter