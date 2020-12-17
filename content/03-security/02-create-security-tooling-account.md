---
title: 'Create Security Tooling AWS Account'
menuTitle: '2. Create Security Tooling Account'
disableToc: true
weight: 20
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section addresses how to set up .

{{< toc >}}

## 1. Create security tooling AWS account

Use AWS Control Tower Account Factory to provision a security tooling AWS account.

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
|**`Account email`**|Use the security tooling email address that you've already identified in [Obtain Email Addresses for New AWS Accounts]({{< relref "02-obtain-email-addresses" >}}).|
|**`Display name`**|**`security-tooling-prod`**|
|**`AWS SSO email`**|Provide the email address of one of your cloud administrators as registered in AWS SSO.  As long as you reference an existing AWS SSO user, the Account Factory will not create another AWS SSO user for this new AWS account.|
|**`AWS SSO First Name`**|**`AWS Control Tower`**|
|**`AWS SSO Last Name`**|**`Admin`**|
|**`Organizational unit`**|**`security_prod`**.|

4. Select **`Enroll Account`**.

It will take several minutes to enroll the new account. You can check the status in **`Service Catalog`**.

## 2. Perform post-creation configuration for security tooling account

Once you create a new AWS account using Account Factory, there are several user account related tasks that you should perform to enhance the security of your environment.

### 2.1 Remove individual access to the account

Since AWS Control Tower's Account Factory automatically grants the AWS SSO user specified in the Account Factory parameters administrative access to the newly created AWS account, you should remove this individual access.  Since you'll grant your Cloud Administrators access to the new AWS account using their AWS SSO group in a subsequent step, there's no need to leave this individual access in place.

1. Navigate to **`AWS SSO`**.
2. Access **`AWS accounts`** in AWS SSO.
3. Select the newly created test AWS account.
4. Select **`Remove access`** from the **`User/group`** entry that matches the AWS SSO email address you supplied in the previous step.
5. Select **`Remove access`** to confirm removal.

### 2.2 Initialize AWS account's root user 

1. **Set AWS account root user password**: See [Log In as Root User](https://docs.aws.amazon.com/controltower/latest/userguide/best-practices.html#root-login) in the AWS Control Tower documentation for instructions to set the root user’s password.

2. **Enable multi-factor authentication (MFA)**: See [Enable MFA on the AWS Account Root User](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html#id_root-user_manage_mfa) for instructions to enable MFA.

## 3. Provide Cloud Administrators access to the new AWS account

Since Cloud Administrators won't automatically be granted sufficient access to newly created AWS accounts, you need to enable this access each time you create new AWS accounts via AWS Control Tower's Account Factory.

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the AWS **`management`** account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`AWS SSO`**.
6. Access **`AWS accounts`** in AWS SSO.
7. Select the checkboxes next to security tooling AWS account.
8. Select **`Assign users`**.
9. Select **`Groups`**.
10. Select the checkbox next to the group **`example-cloud-admin`** or similar.
11. Select **`Next: Permission sets`**.
12. Select the checkbox next to **`AWSAdministratorAccess`**.
13. Select **`Finish`**.

Now you've enabled all users who are part of the Cloud Administrator group in AWS SSO administrator access to the selected AWS account

## 4. Onboard security administrators

...







