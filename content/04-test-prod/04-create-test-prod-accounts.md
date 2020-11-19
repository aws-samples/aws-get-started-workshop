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

If you've followed this guide, you've already created the Organizational Units (OUs) for your workload, and provisioned an initial account in the `workloads_dev` OU.  This step assumes you are ready to provision In this step your Cloud Administrators will create new AWS accounts dedicated for your workload via AWS Control Tower's Account Factory.  

For purposes of this guide, we presume to create one production and one test account for the given workload.  If you've followed the steps closely so far, you've created a foundation that will scale to manage many accounts with a minimum of overhead.  

This step should take about 60 minutes to complete.

{{< toc >}}

## 1. Verify Pre-requisites

### 1.1 Confirm email addresses

Every AWS account requires a unique email address for the "root" user.  You may have [created these addresses in an earlier step]({{< relref "02-obtain-email-addresses" >}}).  If not, please go back and review the guidance and provision the test and production workload addresses before you continue.  You will need to be capable of accessing the inboxes of the email accounts to proceed through the steps below.

### 1.2 Choose workload group identifier

Since test and production workloads are best provisioned in workload-specific accounts, you should determine a workload identifier to associate with your first few workloads.  You'll use that identifier when you name your test and production AWS accounts. For example, if you're workload is a virtual desktop infrastructure (VDI) deployment using, for example, [Amazon WorkSpaces](https://aws.amazon.com/workspaces/?workspaces-blogs.sort-by=item.additionalFields.createdDate&workspaces-blogs.sort-order=desc), you might use `vdi` as the workload identifier and name your accounts `workloads-test-vdi` and `workloads-prod-vdi`.

## 2. Create test workloads AWS account

Use AWS Control Tower Account Factory to provision the required production workload account.

### Log in as a cloud administrator

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the AWS **`management`** account.
3. Navigate to **AWS Control Tower** from the Services menu.

### Create an account

1. Select **`Account Factory`** on the left.
2. Select **`Enroll account`**
3. Fill out the Enroll account form details to create the Test account for the Workload.

|Field|Recommendation|
|-----|---------------|
|**`Account email`**|Use email address that you've already identified.|
|**`Display name`**|`workloads-test-<workload-id>`|
|**`AWS SSO email`**|Use the email address of your **`AWS Control Tower Admin`** user in AWS SSO.  As long as you reference an existing AWS SSO user, the Account Factory will not create another AWS SSO user for this new AWS account.|
|**`AWS SSO First Name`**|**`AWS Control Tower`**|
|**`AWS SSO Last Name`**|**`Admin`**|
|**`Organizational unit`**|**`workloads_test`**.|

4. Select **`Enroll Account`**.

It will take several minutes to enroll the new account. You can check the status in **`Service Catalog`**.

## 3. Perform post-creation configuration for test workloads account

Once you create a new AWS account using Account Factory, there are several user account related tasks that you should perform to enhance the security of your environment.

### 3.1 Remove individual access to the account

Since AWS Control Tower's Account Factory automatically grants the AWS SSO user specified in the Account Factory parameters administrative access to the newly created AWS account, you should remove this individual access.  Since you'll grant your Cloud Administrators access to the new AWS account using their AWS SSO group in a subsequent step, there's no need to leave this individual access in place.

1. Navigate to **`AWS SSO`**.
2. Access **`AWS accounts`** in AWS SSO.
3. Select the newly created test AWS account.
4. Select **`Remove access`** from the **`User/group`** entry that matches the AWS SSO email address you supplied in the previous step.
5. Select **`Remove access`** to confirm removal.

### 3.2 Initialize AWS accounts' root user 

1. **Set AWS Account Root User Password**: See [Log In as Root User](https://docs.aws.amazon.com/controltower/latest/userguide/best-practices.html#root-login) in the AWS Control Tower documentation for instructions to set the root user’s password.

2. **Enable Multi-Factor Authentication (MFA)**: See [Enable MFA on the AWS Account Root User](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html#id_root-user_manage_mfa) for instructions to enable MFA.

## 4. Create production workloads AWS account

{{% notice warning %}}
**Account Factory can create only one account at a time**: You'll need to wait for provisioning of the test workloads account to finish before you start creating the production account.
{{% /notice %}}

Repeat the account creation steps you used for the test workloads account, but substitute **`prod`** where appropriate.

Perform the same post-account creation steps as noted above for your production workloads account.

## 5. Provide cloud administrators access to the new AWS accounts

Since Cloud Administrators won't automatically be granted sufficient access to newly created AWS accounts, you need to enable this access each time you create new AWS accounts via AWS Control Tower's Account Factory.

1. Navigate to **`AWS SSO`**.
2. Access **`AWS accounts`** in AWS SSO.
3. Select the checkboxes next to the workload AWS accounts.
4. Select **`Assign users`**.
5. Select **`Groups`**.
6. Select the checkbox next to the group `example-cloud-admin` or similar.
7. Select **`Next: Permission sets`**.
8. Select the checkbox next to **`AWSAdministratorAccess`**.
9. Select **`Finish`**.

Now you've enabled all users who are part of the Cloud Administrator group in AWS SSO administrator access to the selected AWS accounts.