# About #
This repo contains docker resources to build and setup a php environment and also deploy an EC2 mongodb instance using Cloudformation.

The docker-compose services include the following components:
* Nginx
* PHP7.1-FPM
* MongoDB ​3.4
* Redis ​4.0
* Phalcon ​3.2.3
* XDebug
* Git
* Composer
* NodeJS 9.x and NPM

## Running The Docker Solution ##

Please run the following command to stand up the environment:

```bash
git clone https://github.com/pennywisdom-other/ivg.git
cd ivg
docker-compose up --build
```

Then you navigate to localhost:8080/index.php

## Running the Cloudformation Template ##

You will need access to the AWS console of have the aws cli installed locally.

### Using aws cli ###

```bash
aws cloudformation create-stack --stack-name ivgmongonode --template-body file:///./cloudformation.yml --parameters ParameterKey=MongoDBSecurityGroupID,ParameterValue=[your-sg-group] ParameterKey=IAMProfileID,ParameterValue=[your-iam-profile]  ParameterKey=Subnet,ParameterValue=[your-subnet-id-here] ParameterKey=InstanceType,ParameterValue=m4.large ParameterKey=ImageId,ParameterValue=[your_ami_id] ParameterKey=KeyName,ParameterValue=[your_key_pair_name] ParameterKey=NodeName,ParameterValue=[the_node_name]
```
