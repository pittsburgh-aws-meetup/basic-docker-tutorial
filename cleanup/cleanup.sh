#!/usr/bin/env bash

echo "This script is meant to be helpful, but should not be considered a fully reliable mechanism for shutting down resources."
echo "The deletion of the task, cluster, and ECR repo (the things that cost money) should be verified manually"
echo "This script expects the task ARN as an argument"
echo "This script does no error handling, at the moment, so caller beware."
echo "At worst this script should throw errors, it should not be able to cause damage"

echo "Stopping task"
echo "Stopping task" > results.txt
aws ecs stop-task --cluster paws-demo --task $1 >> results.txt
echo "Detaching AmazonECSTaskExecutionRolePolicy policy from ecsTaskExecutionRole"
echo "Detaching AmazonECSTaskExecutionRolePolicy policy from ecsTaskExecutionRole" >> results.txt
aws iam detach-role-policy --role-name ecsTaskExecutionRole --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy >> results.txt
echo "Deleting role ecsTaskExecutionRole"
echo "Deleting role ecsTaskExecutionRole" >> results.txt
aws iam delete-role --role-name ecsTaskExecutionRole >> results.txt
echo "De-registering task definition paws-demo:1"
echo "De-registering task definition paws-demo:1" >> results.txt
aws ecs deregister-task-definition --task-definition paws-demo:1 >> results.txt
# The following sleep is here to give time for work above to trickle down a bit
# the security group cannot be deleted while it has living dependencies
sleep 3
echo "Deleting webrick security group"
echo "Deleting webrick security group" >> results.txt
aws ec2 delete-security-group --group-name webrick >> results.txt
echo "Deleting paws-demo cluster"
echo "Deleting paws-demo cluster" >> results.txt
aws ecs delete-cluster --cluster paws-demo
echo "Deleting pgh-aws-users-demo ECR repo"
echo "Deleting pgh-aws-users-demo ECR repo" >> results.txt
aws ecr delete-repository --repository-name pgh-aws-users-demo --force
