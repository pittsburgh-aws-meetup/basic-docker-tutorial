# Lab 4 - Pushing the image to ECR

### Our docker image

We are using the same image created in lab2, and used in lab3.  
We can verify it is present with the following command:

    docker images | grep pgh-aws-users-demo

This should list our image.

### Creating our ECR repository

Use the following command to create your repository:

`aws ecr create-repository --repository-name pgh-aws-users-demo`

### Tagging image for ECR and pushing via Docker push

One way to load your docker image to AWS ECR is to tag it using the following command:

`docker tag <image id> <aws_account_id>.dkr.ecr.<region>.amazonaws.com/<my-tag>`

We now have to have docker login to ecr, so that it can push.  We can use the following command for that:  
`aws ecr get-login --region us-west-2 --no-include-email`

Which will give us this output:

```
docker login -u AWS -p <an extremely long secure password> https://424328483274.dkr.ecr.us-west-2.amazonaws.com
```

We can then use the previous command, but this time directly eval it:  
`eval $(aws ecr get-login --no-include-email)`

And now finally, we can use docker push to push the image to AWS ECR:

`docker push <aws_account_id>.dkr.ecr.<region>.amazonaws.com/<my-tag>`



