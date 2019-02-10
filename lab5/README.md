# Lab 5 - Deploying on AWS Fargate

### No prerequisites!
Technically we need to know the tag we used in previous lab when pushing the image to ECR.


### So much AWS stuff that we need...

We want to run an ECS task on fargate.

So we need a ECS cluster!

`aws ecs create-cluster --cluster-name paws-demo`

But we want to run a webapp from our task, so we need a security group that allows traffic to 9292

`aws ec2 create-security-group --group-name webrick --description "allow traffic for webrick"`

Not the security group ID for future use. (`/sg-\w*/`)

...but that doesn't allow traffic to port 9292 yet, we need to create a rule on it.

`aws ec2 authorize-security-group-ingress --group-id <sg-id> --protocol tcp --port 9292 --cidr 0.0.0.0/0`

Now we have our cluster and our security group, we still need an IAM role for our task definition.

`aws iam create-role --role-name ecsTaskExecutionRole --description "ECS task execution role" --assume-role-policy-document file://$(pwd)/lab5/trust-relationship.json`

When created we need to attach a role policy to that, we want the AWS managed policy "AmazonECSTaskExecutionRolePolicy"

`aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy --role-name ecsTaskExecutionRole`

Now finally, we are ready to create our task definition!

`aws ecs register-task-definition --cli-input-json file://$(pwd)/lab5/task-definition.json`

And now we need to run it...  
Which means we need to know the VPC ID and the subnet ID we want to use:  
`aws ec2 describe-subnets`

Which we then stick into this command:  
`aws ecs run-task --cluster paws-demo --task-definition paws-demo --network-configuration "awsvpcConfiguration={subnets=[subnet-9f05adc5],securityGroups=[sg-07477ba0b3f79e833],assignPublicIp=ENABLED}" --launch-type FARGATE`

... and now we should finally have our task running.

Let's verify it!

First we have to describe out running task:  
`aws ecs describe-tasks --cluster paws-demo --tasks <taskArn>`

From the out put of the last command grab the "Network Interface ID" (`/eni-\w*/`) and run this command:  
`aws ec2 describe-network-interfaces --network-interface-ids <eni-id>`

to find the public IP address.

Then look up that IP with port 9292, and see if we see the proper message.