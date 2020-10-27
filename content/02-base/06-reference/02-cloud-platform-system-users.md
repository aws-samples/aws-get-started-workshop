---
title: "Cloud Platform System Users"
disableToc: true
weight: 20
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

The following users are created as part of setting up AWS accounts and establishing your initial foundation on AWS.  After an initial set of human users are onboarded to the platform with the appropriate permissions, the following accounts will rarely be used. A best practice is to store the credentials for these accounts in your enterprise standard secrets or password management solution and grant and audit access to these credentials to a very limited set of foundation team members.

{{< toc >}}

## AWS account root user

It is strongly recommended that AWS account root users not be used for day-to-day administrative tasks. See [The AWS Account Root User](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html) for more specific guidance.

In your master AWS account, the only initial purpose of the AWS account root user is for you to perform initial configuration of several AWS account settings and to create an administrative bootstrap user in the IAM service. 

Your Cloud Administrators will only need to use the AWS account root user for carrying out infrequent tasks described in [AWS Tasks That Require AWS Account Root User Credentials](https://docs.aws.amazon.com/general/latest/gr/aws_tasks-that-require-root.html).

**Creation:** Automatically created whenever an AWS account is created.

**Identity Store:** Not applicable. Built into each AWS account.

**AWS Accounts:** Each AWS account.

**Username:** Email address associated with the AWS account.

**Permissions:** Full administrative access. Also see [AWS Tasks That Require AWS Account Root User Credentials](https://docs.aws.amazon.com/general/latest/gr/aws_tasks-that-require-root.html).

## Administrative bootstrap IAM user

Since it's best practice to avoid using the AWS account root user unless absolutely necessary and setting up a landing zone via AWS Control Tower cannot be done with the root user, it is recommended that a bootstrap administrative user be defined in the Master AWS account to be used to carry out the initial landing zone set up.

Once the human Cloud Administrators are granted access to the management account via their own individual user accounts and are granted at least equivalent permissions to this user, this user will no longer be used.

**Creation:** Manually created by your Cloud Administrators as part of setting up your initial master AWS account.

**Identity Store:** AWS IAM Users

**AWS Accounts:** Master AWS account.	

**Username:** "Administrator" (recommended)

**Permissions:** [AdministratorAccess](https://console.aws.amazon.com/iam/home#/policies/arn%3Aaws%3Aiam%3A%3Aaws%3Apolicy%2FAdministratorAccess)

## AWS Control Tower administrator

Once human Cloud Administtrators are granted access to the management account via their own individual user accounts and are granted at least equivalent permissions to this user, this user will no longer be used.

**Creation:** Automatically created when you create your landing zone via AWS Control Tower.

**Identity Store:** AWS SSO

**AWS Accounts:** Each AWS master and member account under management of AWS Control Tower.

**Username:** Email address associated with the AWS Organizations master AWS account's root user.

**Permissions:** In the master AWS account: [AdministratorAccess](https://console.aws.amazon.com/iam/home#/policies/arn%3Aaws%3Aiam%3A%3Aaws%3Apolicy%2FAdministratorAccess)

In each member AWS account: [AWSOrganizationsFullAccess](https://console.aws.amazon.com/iam/home?#/policies/arn%3Aaws%3Aiam%3A%3Aaws%3Apolicy%2FAWSOrganizationsFullAccess)