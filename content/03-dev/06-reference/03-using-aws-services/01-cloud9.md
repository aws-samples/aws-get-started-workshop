---
title: "Using AWS Cloud9 in Team Development Environments"
menuTitle: "AWS Cloud9"
disableToc: true
weight: 10
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This document highlights special considerations when using the [AWS Cloud9](https://aws.amazon.com/cloud9/) IDE in your team development AWS accounts.

## Why Use AWS Cloud9?
If you have challenges getting the AWS CLI and other tools installed on your corporate desktop, you may find it useful to use AWS Cloud9, a web-based IDE that enables you to deploy a development environment in your AWS account.  

Each Cloud9 environment is an Amazon EC2 Linux instance that includes a browser-based IDE. You deploy a Cloud9 environment in one of your public subnets and access it via the Cloud9 service.

## Creating a Cloud9 Environment

See [AWS Cloud9](https://docs.aws.amazon.com/cloud9/latest/user-guide/welcome.html) for set up details.

Ensure that you select one of the public subnets given that the Cloud9 service currently requires your environment to be deployed in a public subnet. Since Cloud9 doesn't list the name tag of subnets during the creation process, you may need to access the **`VPC`** service of the AWS Management Console to list the subnets and their names.

## Configuring Your Environment

### Use an EC2 Instance Profile

Once you've created your Cloud9 environment, you can associate an instance profile with your Cloud9 EC2 instance so that your work in your IDE can have similar access permissions as your regular AWS session. See [Create and Use an Instance Profile](https://docs.aws.amazon.com/cloud9/latest/user-guide/credentials.html#credentials-temporary).  

For example, you could associate the managed IAM policy `AdministratorAccess` with your new EC2 service role for Cloud9.  Since in your team development AWS account you're required to attach the permissions boundary whenever you create a role, your overall access will be constrained by the permissions boundary policy.

After you attach an EC2 instance profile and IAM role to your Cloud9 instance, you can verify which role is being used by issuing the following command from a terminal session in your Cloud9 environment:

```
$ aws sts get-caller-identity
```

### Update Your Bash Prompt

If you find that your bash terminal prompt is too long, you can set it to just the Linux user, IP address, and current directory. Either edit your `~/.bashrc` file and replace the `PS1` setting or export the setting as follows:

```
export PS1="[\u@\h \W]\$ "
```

### Install Latest AWS CLI

Although a version of the AWS CLI is preinstalled in your Cloud9 environment, you should consider installing version 2.  See [Install the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).