# Deploying a sveltkit app on AWS

I need to learn how to use AWS and decided to launch a simple SveltKit app on
AWS. This will be a simple app that has a nodejs backend service with a REST
api.

Possible methods to look into are Elastic BeanStalk, ECS with fargate or EC2, or
just using plain EC2.

## Key things

- deploy on `us-east-2`
- use t4g.small

  This a 2 vCPU and 2G arm64 based instance

## Elastic beanstalk

Key featues

- node version: 18.12.1

[platform details]:
  https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html#platforms-supported.nodejs

## ECS with fargate

This is serverless docker containers (I think).

## TODO

- [ ] TODO: Apply principle of least privilege on AWS
- [ ] TODO: Research deployment strategies

## See also

- [AWS free tier](../340)

## Meta

    tags: #webdev #aws #svelte
