# Lab 3 - Running a Docker container

### Our app

It is in the docker image we created last lab.  We no longer need to have access to the source code.


### Our docker image

We can verify it is present with the following command:

    docker images | grep pgh-aws-users-demo

This should list our image.


### Running our image

The basic run command is:

    docker run <image_name>
    
However, this does not open up any ports, a feature that is very much needed for a webapp.

    docker run -p 9292:9292 pgh-aws-users-demo:latest

And that is that, we have a docker container that runs locally.