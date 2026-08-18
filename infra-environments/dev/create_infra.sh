#!/bin/bash

set -e

echo "Applying terraform network layer"

cd network/
terraform init
terraform plan -out network-terraform-plan
terraform apply network-terraform-plan

cd ..
echo "Applying terraform eks layer"

cd eks/
terraform init
terraform plan -out eks-terraform-plan
terraform apply eks-terraform-plan 
cd ..

echo "Applying terraform addons layer"

cd k8s-addons/
terraform init
terraform plan -out addons-terraform-plan
terraform apply addons-terraform-plan 
cd ..

echo "Whole terraform infrastructure created"
