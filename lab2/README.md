# Lab 2 - Building a docker image

### Our app  
We have the same app in ~/src as we did in lab 1.

### Our Dockerfile  
We will need the Dockerfile written in lab 1.

Copy it into this lab with the command `cp ../lab1/Dockerfile .`

We will also need the source files from lab 1.  
Copy them into this lab with the command `cp -R ../lab1/src .`

We will now use Docker to build an image from the Dockerfile.


### Simple command

We can use `docker build .` to build an image.

You should see output that ends with a line similiar to:

`Successfully built 4b7380655b4c`

This indicates that an image with image ID `4b7380655b4c` has been created.

And this can be verified by executing the command `docker images` and looking for it to be listed there.


### A more usable label

We can also use the command `docker build -t pgh-aws-users-demo .` to create an image with a tag of `pgh-aws-users-demo:latest`

The the last lines of the output should be similar to:

```
Successfully built 4b7380655b4c
Successfully tagged pgh-aws-users-demo:latest
```
 