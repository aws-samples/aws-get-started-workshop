---
title: 'Create Test and Production Workload AWS Accounts'
menuTitle: '4. Create Test and Prod Accounts'
disableToc: true
weight: 40
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

{{% notice note %}}
Review Note: This section is an early draft and undergoing reviewing and editing.
{{% /notice %}}

If you've followed this guide, you've already created the Organizational Units (OUs) for your workload, and provisioned an initial account in the `workloads_dev` OU.  This step assumes you are ready to provision In this step your Cloud Administrators will create new AWS accounts dedicated for your workload via AWS Control Tower's Account Factory.  

For purposes of this guide, we presume to create one production and one test account for the given workload.  If you've followed the steps closely so far, you've created a foundation that will scale to manage many accounts with a minimum of overhead.  

This step should take about 60 minutes to complete.

{{< toc >}}

## 1. Verify Pre-requisites
- **Confirm email addresses** Every AWS account requires a unique email address for the "root" user.  You may have [created these addresses in an earlier step]({{< relref "02-obtain-email-addresses" >}}).  If not, please go back and review the guidance and provision the test and production workload addresses before you continue.  You will need to be capable of accessing the inboxes of the email accounts to proceed through the steps below.

- **Choose Workload Group Identifier** When you [created the development workload environment]({{< ref "05-create-team-dev-accounts" >}}), you used `<team identifier>` as a differentiator.  Test and production workloads are best provisioned in workload-specific accounts so we'll use the workload group ID to label them.  For example, `workloads-test-sap` and `workloads-prod-sap` where `sap` would be the workload group ID.

## 2. Create Production Workload AWS Account
Use AWS Control Tower Account Factory to provision the required production workload account.

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the AWS **`management`** account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`Control Tower`**.
6. Select **`Account Factory`** on the left.
7. In the upper right, click **`Enroll account`**.
8. Fill out the Enroll account form details to create the Production account for the Workload.

|Field|Recommendation|
|-----|---------------|
|**`Account email`**|Use the prod email created in Step 1 above.|
|**`Display name`**|`workloads-prod-<workloadId>`
|**`AWS SSO email`**|Use the email address of your **`AWS Control Tower Admin`** user in AWS SSO.  As long as you reference an existing AWS SSO user, the Account Factory will not create another AWS SSO user for this new AWS account.|
|**`AWS SSO First Name`**|**`AWS Control Tower`**|
|**`AWS SSO Last Name`**|**`Admin`**|
|**`Organizational unit`**|**`workloads_prod`**.|

9. Select **`Enroll Account`**.

It will take several minutes to enroll the new account. You can check the status in **`Service Catalog`**.


{{% notice warning %}}
By default, AWS Control Tower will only allow one account provisioning request to be active at a time.  If you try to enroll a second account while the first one is provisioning, it will fail and you will need to terminate the request in Service Catalog and start over.  You can request an increase in this soft limit via ticket to AWS Support.
{{% /notice %}}

## 3. Perform Post-Creation Tasks for Prod Account

Once you create a new AWS account using Account Factory, there are several user account related tasks that you should perform to enhance the security of your environment.

### Remove Individual Access to the New AWS Account

Since AWS Control Tower's Account Factory automatically grants the AWS SSO user specified in the Account Factory parameters administrative access to the newly created AWS account, you should remove this individual access.  Since you'll grant your Cloud Administrators access to the new AWS account using their AWS SSO group in a subsequent step, there's no need to leave this individual access in place.

1. Navigate to **`AWS SSO`**.
2. Access **`AWS accounts`** in AWS SSO.
3. Select the newly created prod AWS account.
4. Select **`Remove access`** from the **`User/group`** entry that matches the AWS SSO email address you supplied in the previous step.
5. Select **`Remove access`** to confirm removal.

### Initialize AWS Accounts' Root User  

1. **Set AWS Account Root User Password**: See [Log In as Root User](https://docs.aws.amazon.com/controltower/latest/userguide/best-practices.html#root-login) in the AWS Control Tower documentation for instructions to set the root user’s password.

2. **Enable Multi-Factor Authentication (MFA)**: See [Enable MFA on the AWS Account Root User](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html#id_root-user_manage_mfa) for instructions to enable MFA.

## 4. Create Test Workload AWS Account
Follow the same steps to create the test workload account.  Ensure the previous step has completed before you proceed.

1. Select **`Account Factory`** on the left.
2. In the upper right, click **`Enroll account`**.
3. Fill out the Enroll account form details to create the Test account for the Workload.

|Field|Recommendation|
|-----|---------------|
|**`Account email`**|Use the test email created in Step 1 above.|
|**`Display name`**|`workloads-test-<workloadId>`
|**`AWS SSO email`**|Use the email address of your **`AWS Control Tower Admin`** user in AWS SSO.  As long as you reference an existing AWS SSO user, the Account Factory will not create another AWS SSO user for this new AWS account.|
|**`AWS SSO First Name`**|**`AWS Control Tower`**|
|**`AWS SSO Last Name`**|**`Admin`**|
|**`Organizational unit`**|**`workloads_test`**.|

9. Select **`Enroll Account`**.

It will take several minutes to enroll the new account. You can check the status in **`Service Catalog`**.


## 5. Perform Post-Creation Configuration for Test Account

Once you create a new AWS account using Account Factory, there are several user account related tasks that you should perform to enhance the security of your environment.

### Remove Individual Access to the New AWS Accounts

Since AWS Control Tower's Account Factory automatically grants the AWS SSO user specified in the Account Factory parameters administrative access to the newly created AWS account, you should remove this individual access.  Since you'll grant your Cloud Administrators access to the new AWS account using their AWS SSO group in a subsequent step, there's no need to leave this individual access in place.

1. Navigate to **`AWS SSO`**.
2. Access **`AWS accounts`** in AWS SSO.
3. Select the newly created test AWS account.
4. Select **`Remove access`** from the **`User/group`** entry that matches the AWS SSO email address you supplied in the previous step.
5. Select **`Remove access`** to confirm removal.


### Initialize AWS Accounts' Root User  

1. **Set AWS Account Root User Password**: See [Log In as Root User](https://docs.aws.amazon.com/controltower/latest/userguide/best-practices.html#root-login) in the AWS Control Tower documentation for instructions to set the root user’s password.

2. **Enable Multi-Factor Authentication (MFA)**: See [Enable MFA on the AWS Account Root User](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html#id_root-user_manage_mfa) for instructions to enable MFA.

## 6. Provide Cloud Administrators Access to New AWS Accounts
Since Cloud Administrators won't automatically be granted sufficient access to newly created AWS accounts, you need to enable this access each time you create new AWS accounts via AWS Control Tower's Account Factory.

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the AWS **`management`** account.
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
