# lambda-pkg-build
Python 3.6 packages for AWS lambda. 

# Dependencies
Docker

# How to run it
./scripts/build.sh

### scipy ###
can't use scipy==1.0.0 in the builder. It can't be stripped. need to investigate.

### Reference ###
* https://serverlesscode.com/post/deploy-scikitlearn-on-lamba/
* https://github.com/lambci/docker-lambda
* https://github.com/joblib/joblib/pull/402/files
* https://medium.com/@maebert/machine-learning-on-aws-lambda-5dc57127aee1
