# Cleanup

This script is meant to be helpful, but should not be considered a fully reliable mechanism for shutting 
down resources.  The deletion of the task, cluster, and ECR repo (the things that cost money) should be verified manually.  

This script does no error handling, at the moment, so caller beware.
At worst this script should throw errors, it should not be able to cause damage.

This script expects the task ARN as an argument, but there is no argument handling.