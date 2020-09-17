---
title: "Using Amazon Redshift in Team Development Environments"
menuTitle: "Amazon Redshift"
disableToc: true
weight: 30
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This document highlights special considerations when using [Amazon Redshift](https://aws.amazon.com/redshift/) in your team development AWS accounts.

{{% notice note %}}
**Review Note:** This is a draft document.
{{% /notice %}}

## Resources

If you plan to use the [Redshift Immersion Labs](https://redshift-immersion.workshop.aws/en), section 1. Creating a Cluster, won't be completely aligned with your permissions available in your development AWS account.

For example, since the AWS CloudFormation template provided in the labs attempts to create a VPC and you don't have those permissions in your development AWS account, the template will not work in your environment.  Instead, you can either follow the directions in the lab to use the AWS Management Console to create the dependencies and the cluster or, if you're more adventurous, you could modify the CloudFormation template to exclude creation of the VPC and make other adjustments.

## Create a VPC Security Group

1. Navigate to the **`VPC`** service.
2. Select **`Subnets`**.
3. Select **`Create security group`**.
4. Assign a name to the security group in the **`Name`** column.
5. Select **`Inbound Rules`**.
6. Select **`Edit rules`**.
7. Add a rule with TCP protocol, 5439 Port Range and Source set to anywhere.

## Create Cluster Subnet Group

1. Navigate to the **`Redshift`** service.
2. Select **`Config`** and **`Subnet groups`**.
3. Create a new subnet group using the private subnets of the shared development VPC.

## Create IAM Service Role to Access S3

1. Navigate to the **`IAM`** service.
2. Select **`Roles`**.
3. Select **`Create role`**.
4. Select **`Redshift`**.
5. Select the use case of **`Redshift - Customizable`**.
6. Select **`Next: Permissions`**.
7. Attach the **`AmazonS3ReadOnlyAccess`** and **`AWSGlueConsoleFullAccess`** policies to the role.
8. Expand **`Set permissions boundary`**.
9. Select **`Use a permissions boundary...`**.
10. Select your standard development team permissions boundary policy.
11. Select **`Next: Tags`** and **`Next: Review`**.
12. Provide a name and create the role.

## Create Cluster

1. Select **`Clusters`** and **`Create cluster`**.
2. Under **`Cluster permissions`**, select the IAM service role that you just created.
3. The shared development VPC should be automatically selected.
4. Select the VPC security group that you just created.
5. Ensure that the cluster subnet group you just created is selected.