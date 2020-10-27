---
title: "Create AWS Cloud9 Environments in Your Team Development Environments"
menuTitle: "Create Cloud9 Environments"
disableToc: true
weight: 20
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This document addresses special considerations for creating [AWS Cloud9](https://aws.amazon.com/cloud9/) development environments in your team development AWS accounts. As long as a pre-requisite has been addressed by your Cloud Administration team, you as a builder can self-service create AWS Cloud9 environments in your team development AWS account.

## Ensure pre-requisite has been satisfied

If you do not see the AWS IAM role `AWSCloud9SSMAccessRole` in your team development AWS account, then your Cloud Administration team has not yet established this IAM role in your environment. Contact the team and ask them to follow the instructions to [Establish IAM Service Role for AWS Cloud9]({{< relref "01-prepare-for-cloud9" >}}).

## Creating a Cloud9 environment

1. Use your personal user to log into AWS SSO.
2. Select your team development AWS account.
3. Select **`Management console`** associated with the team development role.
4. Navigate to the **`Cloud9`** service
5. Follow the instructions on [Creating an EC2 environment](https://docs.aws.amazon.com/cloud9/latest/user-guide/create-environment-main.html), but take into consideration the following recommendations:

|Setting|Recommendation|
|---------|--------|
|**`Environment type`**|Select **`Create a new no-ingress EC2 instance for environment (access via Systems Manager)`**. This is the type that supports use of private subnets.|
|**`Instance type`**|Select the instance type that will suit your needs.|
|**`Platform`**|If you would like to use an Amazon Linux platform, it's recommended that you select **`Amazon Linux 2`**.|
|**`Network settings`**|The shared development VPC should be pre-selected. You can select any of the shared development private subnets.|

## Limitations of using Cloud9 in your team development environment

In your Cloud9 environment, the EC2 instance has an EC2 instance profile and IAM service role `AWSCloud9SSMAccessRole` associated with it. Since the IAM service role is fixed, you as a builder do not have access to change it. Consequently, your Cloud9 environment might be constrained by the actions in can perform in your team development AWS account.

## Using Cloud9

See the [AWS Cloud9 User Guide](https://docs.aws.amazon.com/cloud9/latest/user-guide/welcome.html) for information on using Cloud9.

### Update Your Bash Prompt

If you find that your bash terminal prompt is too long, you can set it to just the Linux user, IP address, and current directory. Either edit your `~/.bashrc` file and replace the `PS1` setting or export the setting as follows:

```
export PS1="[\u@\h \W]\$ "
```

### Install Latest AWS CLI

Although a version of the AWS CLI is preinstalled in your Cloud9 environment, you should consider installing version 2 of the AWS CLI.  See [Install the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).
