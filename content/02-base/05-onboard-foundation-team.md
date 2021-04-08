---
title: 'Onboard Foundation Team'
pre: '5. '
disableToc: true
weight: 50
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this step either your Security or Cloud Administrators will onboard the few people that make up the initial foundation team so that they can stop using system users and start using their own user accounts to manage the foundation.

This step should take about 20 minutes to complete.

{{< toc >}}

## 1. Create AWS SSO users for foundation team members

In preparation for adding foundation team users to AWS SSO, decide on the format of the user name.  Typically, the user name will simply be the user's corporate email address that is often used for SaaS services.

Next, access the AWS SSO service to begin adding an AWS SSO user for each foundation team member:

1. If you don't already have a personal user account with administrator access, sign in to the AWS SSO URL for your environment using the **`AWS Control Tower Administrator`** user.
2. Select the AWS **`management`** account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`AWS SSO`**.
6. Access **`Users`** in AWS SSO.
7. Select **`Add user`**.
8. Specify a user name and complete at least the other required fields.
9. Select **`Next: Groups`**.
10. Select the checkbox for each corresponding AWS SSO group based on [Mapping of Functional Roles to AWS SSO Groups]({{< relref "03-set-up-foundation-team-access-control#map-foundation-functional-roles" >}}).
11. Select **`Add user`**.

## 2. Onboard your foundation team members 

Reach out to each foundation team member to inform them of the context of the email message they received, what they should do next, and what access they have been granted.

Their initial sign on experience will consist of:

1. Receiving the email invitation to the AWS SSO service.
1. Clicking on the **`Accept invitation`** link to set their initial password.
3. Being directed to AWS SSO landing page where they can select from the set of AWS accounts for which they have access.
4. Selecting from the permissions that they can assume for each AWS account.
5. Using either the AWS Management Console or AWS CLI/API to access each AWS account.

Inform the foundation team members that use of MFA is required and how they can [register an MFA device](https://docs.aws.amazon.com/singlesignon/latest/userguide/how-to-register-device.html) on their own via the AWS SSO service.

## 3. Sign out of the AWS Control Tower Administrator user and sign in with your individual user

Since you've onboarded yourself and your Cloud Admin team members to the Cloud Admin group that has permissions to log into the current set of AWS accounts, you should log out of the `AWS Control Tower Administrator` user and log in using your own user.

1. Sign out of the AWS SSO landing page.
1. Sign in to the AWS SSO URL for your environment using your individual user account.
2. Select the AWS **`management`** account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.

## 4. Delete the AWS Control Tower Admin user and associated group in AWS SSO

In this step you'll delete the AWS Control Admin user and the associated group from AWS SSO.

Since you've onboarded foundation team members with the appropriate permissions, there's no longer any reason for your Cloud Administrators to use the AWS Control Tower Administrator user. From this point forward, the vast majority of your work done by your cloud administrators should be done via their individual user accounts that are defined in AWS SSO.  By using individual users accounts, all operations will be auditable and tied to specific individuals.

### 4.1 Delete the `AWS Control Tower Administrator` user

1. Navigate to **`AWS SSO`**.
2. Access **`Users`** in AWS SSO.
3. Select the checkbox next to the **`AWS Control Tower Administrator`** user.
4. Select **`Delete users`**.
5. Delete the user.

### 4.2 Delete the `AWSControlTowerAdmins` group

Since you already have a cloud administrators group in AWS SSO, you no longer need the `AWSControlTowerAdmins` group.

You can safely delete this group from AWS SSO and instead use the  **`example-cloud-admin`** or equivalent group that you've already established.

### 4.3 Delete the `AWSControlTowerAdmins` group permission sets from the AWS accounts

1. Navigate to **`AWS SSO`**.
2. Access **`Users`** in AWS SSO.
3. Select the checkbox next to the **`AWS Control Tower Administrator`** user.
4. Select **`Delete users`**.
5. Delete the user.

## 5. Brief foundation team members

Meet with the foundation team members to brief them on their access, responsibilities, and other topics covered in the [Example Getting Started Guide for Foundation Team Members]({{< relref "01-getting-started-guide-foundation-team-members.md" >}}).