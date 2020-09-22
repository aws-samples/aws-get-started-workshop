---
title: 'Create Prod and Test Workload AWS Accounts'
menuTitle: '2. Create Prod and Test Workload AWS Accounts'
disableToc: true
weight: 20
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

If you've followed this guide, you've already created the Organizational Units (OUs) for your workload, and provisioned an initial account in the `workloads_dev` OU.  This step assumes you are ready to provision In this step your Cloud Administrators will create new AWS accounts dedicated for your workload via AWS Control Tower's Account Factory.  

This step should take about 30 minutes to complete.

{{< toc >}}

## 1. Determine Scope of Production AWS Accounts
Placeholder for evolving guidance.

## 2. Determine Requirement For Test Accounts
Each prod workload might have 0-n test accounts, depending on the requirements.

## 3. Provision Unique Email Address For Each Account

## 4. Create Workload AWS Accounts

In AWS Control Tower, provision the required workload accounts.

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
|**`Account email`**|Use the appropriate email created in Step 3 above.|
|**`Display name`**|**`<env>-<workloadId>`
|**`AWS SSO email`**|Use the email address of your **`AWS Control Tower Admin`** user in AWS SSO.  As long as you reference an existing AWS SSO user, the Account Factory will not create another AWS SSO user for this new AWS account.|
|**`AWS SSO First Name`**|**`AWS Control Tower`**|
|**`AWS SSO Last Name`**|**`Admin`**|
|**`Organizational unit`**|Select **`workloads_test`** or **`workloads_prod`**.|

9. Select **`Enroll Account`**.

It will take a few minutes to enroll the new account. You can check the status in **`Service Catalog`**.

## 3. Perform Post AWS Account Creation User Configuration

Once you create a new AWS account using Account Factory, there are several user account related tasks that you should perform to enhance the security of your environment.

### Remove Individual Access to the New AWS Account

Since AWS Control Tower's Account Factory automatically grants the AWS SSO user specified in the Account Factory parameters administrative access to the newly created AWS account, you should remove this individual access.  Since you'll grant your Cloud Administrators access to the new AWS account using their AWS SSO group in a subsequent step, there's no need to leave this individual access in place.

1. Navigate to **`AWS SSO`**.
2. Access **`AWS accounts`** in AWS SSO.
3. Select the newly created prod AWS account.
4. Select **`Remove access`** from the **`User/group`** entry that matches the AWS SSO email address you supplied in the previous step.
5. Select **`Remove access`** to confirm removal.

Repeat these steps for any test AWS accounts  you've created.

### Initialize AWS Account's Root User  

Perform the following steps for each of the new AWS accounts:

1. **Set AWS Account Root User Password**: See [Log In as Root User](https://docs.aws.amazon.com/controltower/latest/userguide/best-practices.html#root-login) in the AWS Control Tower documentation for instructions to set the root user’s password.

2. **Enable Multi-Factor Authentication (MFA)**: See [Enable MFA on the AWS Account Root User](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html#id_root-user_manage_mfa) for instructions to enable MFA.

## 4. Provide Cloud Administrators Access to New AWS Accounts
**NOTE: Do we want this or will we first consider restricting to workload admin account? **
Since Cloud Administrators won't automatically be granted sufficient access to newly created AWS accounts, you need to enable this access each time you create new AWS accounts via AWS Control Tower's Account Factory.

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the AWS **`master`** account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`AWS SSO`**.
6. Access **`AWS accounts`** in AWS SSO.
7. Select the checkboxes next to the workload AWS accounts.
8. Select **`Assign users`**.
9. Select **`Groups`**.
10. Select the checkbox next to the group `example-cloud-admin` or similar.
11. Select **`Next: Permission sets`**.
12. Select the checkbox next to **`AWSAdministratorAccess`**.
13. Select **`Finish`**.

Now you've enabled all users who are part of the Cloud Administrator group in AWS SSO administrator access to the selected AWS accounts.
