#! /bin/bash

terraform show > outputs/terraform-state.txt
terraform output > outputs/terraform-output.txt
terraform validate -json > outputs/terraform-validate.json
terraform plan -no-color > outputs/terraform-plan.txt   # must show "No changes"
docker ps > outputs/docker-ps.txt
docker network inspect exam-network > outputs/docker-network.txt
docker logs exam-health-checker > outputs/health-checker-logs.txt 2>&1
docker inspect --format '{{.State.Health.Status}}' exam-web-server > outputs/nginx-health.txt
curl -s http://localhost:8081 > outputs/nginx-welcome.html


REPO="http://localhost:3000/api/v1/repos/devopsadmin/terraform-docker-exam"
curl -s -H "Authorization: token 15788d43536cd40eaeb3f32ef6362a04cf95035c" $REPO > \
outputs/gitea-repo.json
curl -s -H "Authorization: token 15788d43536cd40eaeb3f32ef6362a04cf95035c" $REPO/branch_protections > \
outputs/gitea-branch-protection.json