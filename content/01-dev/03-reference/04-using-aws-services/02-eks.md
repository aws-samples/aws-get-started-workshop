---
title: "Using Amazon EKS in Team Development Environments"
menuTitle: "Amazon EKS"
disableToc: true
weight: 20
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This document highlights special considerations when using [Amazon Elastic Kubernetes Service (EKS)](https://aws.amazon.com/eks/) in your team development AWS accounts.

{{% notice note %}}
**Review Note:** This is a draft document.
{{% /notice %}}

## Using `eksctl` CLI to Create a Cluster

* Deploy and configure Cloud9 environment
* Install `eksctl` and `kubectl` per [Getting Started with eksctl](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html).
  * Ensure that you have at least `eksctl` version `0.14.0` so that permissions boundary support is available.
  * If the latest version of `eksctl` does not get installed, you might need to replace the `latest_release` portion of the download path with the explicit version of interest. For example, `0.14.0`.
* Review the set of public and private subnets in the **`VPC`** service within the AWS Management Console.
* Set up a cluster config file for `eksctl`.

`nikki-cluster.yml`

```
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: nikki-dev
  region: us-east-2

iam:
  serviceRolePermissionsBoundary: arn:aws:iam::123456789012:policy/example-infra-dev-team-boundary
  fargatePodExecutionRolePermissionsBoundary: arn:aws:iam::123456789012:policy/example-infra-dev-team-boundary

vpc:
  subnets:
    public:
      us-east-2a: { id: subnet-... }
      us-east-2b: { id: subnet-... }
      us-east-2c: { id: subnet-... }
    private:
      us-east-2a: { id: subnet-... }
      us-east-2b: { id: subnet-... }
      us-east-2c: { id: subnet-... }

nodeGroups:
  - name: ng-1
    instanceType: m5.large
    desiredCapacity: 1
    iam:
      instanceRolePermissionsBoundary: arn:aws:iam::123456789012:policy/example-infra-dev-team-boundary
```

* Execute `create cluster`:

```
./eksctl create cluster --config-file nikki-cluster.yml
```

```
$ aws eks --region us-east-2 describe-cluster --name nikki-dev  --query cluster.status                                  
```
