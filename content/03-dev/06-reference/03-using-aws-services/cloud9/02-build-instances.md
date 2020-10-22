---
title: "Start AWS Cloud9 Instances"
menuTitle: "Start AWS Cloud9 Instances"
disableToc: true
weight: 20
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

## Configuring Your Cloud9 Environment
AWS provides a [detailed step-by-step procedure for creating and configuring an AWS Cloud9 environment.](https://docs.aws.amazon.com/cloud9/latest/user-guide/create-environment-main.html)  Each developer will need to configure her own environment.  

1.  Log into AWS SSO as a developer and access the Team Development account.
2.  Follow the process here to access your Cloud9 IDE https://docs.aws.amazon.com/cloud9/latest/user-guide/create-environment-main.html

{{% notice warning %}}
*Make sure you note the following choices to support no-ingress EC2 instances in the shared development subnets.*
{{% /notice %}}

- In **Step 7**, ensure you select **Create a new no-ingress EC2 instance for environment (access via Systems Manager)**
- **Step** 12 will require you to select a VPC and subnet.  If you are using the shared VPC model, there should only be one VPC available and any subnet will work.  
{{ /notice }}

Beyond the above, you might want to change the instance size depending on the workload, but the defaults are the recommended settings.  Please see the [AWS Cloud9 User Guide](https://docs.aws.amazon.com/cloud9/latest/user-guide/welcome.html) for more information

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
