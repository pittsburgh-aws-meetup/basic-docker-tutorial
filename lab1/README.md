# Lab 1 - Creating a Dockerfile


### Our app

There is a simple ruby webapp in the ~/src folder.  
It can be run from the src/ directory by using the command `rackup`.  
This will spin up a Webrick web server, serving a simple app defined in the config.ru file.  
We are going to write a Dockerfile for this application.

#### Details to note

1) The .ruby-version file contains the expected ruby version
2) Webrick by default serves the application on tcp port 9292
3) By default Webrick only listens for connections internal to the host, to enbale it to listen externally we need to
   add `--host 0.0.0.0`