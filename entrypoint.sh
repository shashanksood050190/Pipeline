#!/bin/ash

# Getting the lastest version of the infra we need to deploy and running it.
git clone https://github.com/devops-moonwalkers/gcp-infra.git
cd gcp-infra/
terraform init
terraform plan
