---
title: 'Create Team Development AWS Accounts'
menuTitle: '4. Create Dev AWS Accounts'
disableToc: true
weight: 40
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this step your Cloud Administrators will create several new team development AWS accounts via AWS Control Tower's Account Factory.

This step should take about 30 minutes to complete.

{{< toc >}}

## 1. Use at Least Two Team Development AWS Accounts from the Start

As highlighted previously, an AWS best practice is to isolate the work of distinct builder teams by assigning a different development AWS account to each team. Benefits of this approach include:

* **Inherent Per Team Cost Allocation:** Since AWS resource costs are, by default, attributable to each AWS account in which the resources are provisioned, at this early stage in your adoption, you don't need to force builder teams to use cost allocation tags on their resources.

* **Inherent Isolation Between Teams:** Since cloud resources managed by builder teams using different AWS accounts are, by default, completely isolated from each other, more advanced AWS Identity and Access Management (IAM) configurations are not needed to ensure that builder teams don't inadvertently impact each other's cloud resources.

Initially, you will likely need AWS accounts for the following teams:

|Team Development Account|Purpose|
|----------------|-------|
|**Foundation Team**|A team development AWS account for the initial few Cloud and Security Administrators to experiment, develop, and perform early testing of changes to the foundation.|
|**Workload Builder Team**|A team development AWS account for the team that will be doing the workload specific work for your first formal workload on AWS.|

## 2. Create Team Development AWS Accounts

In AWS Control Tower, provision the initial set of team development AWS accounts for early experimentation, development, and testing. 

You'll follow these steps twice: Once to create the initial builder team development AWS account and again to create the Cloud Foundation team development AWS account.

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the AWS **`master`** account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`Control Tower`**.
6. Select **`Account Factory`** on the left.
7. In the upper right, click **`Enroll account`**.
8. Fill out the Enroll account form details. Some suggested fields are below:

|Field|Recommendation|
|-----|---------------|
|**`Account email`**|Consult the [set of AWS account root user email addresses]({{< relref "04-address-prerequisites#other-aws-accounts" >}}) that you established earlier.|
|**`Display name`**|**`dev-infra`** or **`dev-<team identifier>`**|
|**`AWS SSO email`**|Use the email address of your **`AWS Control Tower Admin`** user in AWS SSO.  As long as you reference an existing AWS SSO user, the Account Factory will not create another AWS SSO user for this new AWS account.|
|**`AWS SSO First Name`**|**`AWS Control Tower`**|
|**`AWS SSO Last Name`**|**`Admin`**|
|**`Organizational unit`**|Select either **`infrastructure_dev`** or **`workloads_dev`**.|

9. Select **`Enroll Account`**.

It will take a few minutes to enroll the new account. You can check the status in **`Service Catalog`**.

## 3. Perform Post AWS Account Creation User Configuration

Once you create a new AWS account using Account Factory, there are several user account related tasks that you should perform to enhance the security of your environment.

### Remove Individual Access to the New AWS Account

Since AWS Control Tower's Account Factory automatically grants the AWS SSO user specified in the Account Factory parameters administrative access to the newly created AWS account, you should remove this individual access.  Since you'll grant your Cloud Administrators access to the new AWS account using their AWS SSO group in a subsequent step, there's no need to leave this individual access in place.

1. Navigate to **`AWS SSO`**.
2. Access **`AWS accounts`** in AWS SSO.
3. Select the **`dev-infra`** AWS account.
4. Select **`Remove access`** from the **`User/group`** entry that matches the AWS SSO email address you supplied in the previous step.
5. Select **`Remove access`** to confirm removal.

Repeat these steps for the **`dev-<team identifier>`** AWS account.

### Initialize AWS Account's Root User  

Perform the following steps for each of the new AWS accounts:

1. **Set AWS Account Root User Password**: See [Log In as Root User](https://docs.aws.amazon.com/controltower/latest/userguide/best-practices.html#root-login) in the AWS Control Tower documentation for instructions to set the root user’s password.

2. **Enable Multi-Factor Authentication (MFA)**: See [Enable MFA on the AWS Account Root User](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html#id_root-user_manage_mfa) for instructions to enable MFA.

## 4. Provide Cloud Administrators Access to New AWS Accounts

Since Cloud Administrators won't automatically be granted sufficient access to newly created AWS accounts, you need to enable this access each time you create new AWS accounts via AWS Control Tower's Account Factory.

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the AWS **`master`** account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`AWS SSO`**.
6. Access **`AWS accounts`** in AWS SSO.
7. Select the checkboxes next to both team development AWS accounts. For example:
  * `dev-infra`
  * `dev-<team identifier>`
8. Select **`Assign users`**.
9. Select **`Groups`**.
10. Select the checkbox next to the group `example-cloud-admin` or similar.
11. Select **`Next: Permission sets`**.
12. Select the checkbox next to **`AWSAdministratorAccess`**.
13. Select **`Finish`**.

Now you've enabled all users who are part of the Cloud Administrator group in AWS SSO administrator access to the selected AWS accounts.

## 5. Apply Names to Shared Private Subnets

Since the names of shared subnets are not currently propagated to AWS accounts, as a Cloud Administrator, you should apply names to the shared subnets within each team development AWS account so that it's easier for the builder teams to understand the role of each subnet as they configure resources for AWS services.

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the team development AWS account of interest.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`VPC`**.
6. Select **`Your VPCs`**.
7. Select the unnamed VPC and assign the same name as used in the **network-prod** AWS account. For example, **`dev-infra-shared`**.
8. Select **`Subnets`**.
9. Update the **`Name`** field of each private subnet to match the name of the private subnet as it's configured in the **network-prod** AWS account. **Caution:** The subnets may not be listed in the same order in both AWS accounts by default.
10. You can optionally apply the same naming alignment for route tables.