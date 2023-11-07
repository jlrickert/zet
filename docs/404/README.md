# Amazon CodePipeline

## Features

- Workflow modeling
- AWS integrations
- pre build and custom receive notifications
- declarative templates
- access control

## Domain model

- Action Provider

  This is something like GitHub

- Pipeline

- Stage

## Services used

- Source: CodeCommit
- Build: CodeBuild
- Test: CodeBuild
- Deploy: CodeDeploy

Monitoring of each step is done by Cloud watch or some other service such as
fluentd or Prometheus.

## See also

- [AWS Services](../391)
- [CI/CD on AWS](../395)

## Meta

    tags: #aws