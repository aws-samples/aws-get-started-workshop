---
title: 'Share Transit Gateway with Other AWS Accounts'
menuTitle: '8. Share Transit Gateway'
disableToc: true
weight: 80
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this section, you will share your transit gateway with other AWS accounts in your AWS organization so that VPCs in those accounts can be attached to the transit gateway.  This is a one-time operation.

{{< toc >}}

## 1. Enable resource sharing in your organizations management AWS account

{{% notice info %}}
**Attaching team development VPC:** The team development VPC is created and managed in the same **`network-prod`** AWS account in which your transit gateway was created. Consequently, you do not need to share the transit gateway resource in order to attach the common team development VPC to your transit gateway. However, since your other VPCs will reside in separate AWS accounts, you will need to enable resource sharing and share the transit gateway in order to attach those VPCs.
{{% /notice %}}

You will need to enable sharing resources within your AWS Organizations from your management account.  This will allow you to access your transit gateway from the other AWS accounts that are part of your AWS organization.

{{% notice info %}}
**Resource sharing may already be enabled:** If you already set up a common team development VPC, then you've already enabled resource sharing and can skip this step.
{{% /notice %}}

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the **`management`** AWS account
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`Resource Access Manager`**
6. Click the **`Settings`** in the left navigation panel
7. Check the **`Enable sharing within your AWS Organizations`** checkbox, then click the **`Save settings`** button

{{% notice info %}}
**Find your Organization ID:** Navigate to AWS Organizations and click on any of the accounts to open the information panel on the right.  Within the **`ARN`**, after the word account, you will see your Organization ID (starts with **`o-`**).  Note this down for the next set of steps.
{{% /notice %}}

## 2. Share your transit gateway with your other AWS accounts

You will use AWS Resource Access Manager (RAM) to share your transit gateway for VPC attachments across your accounts and/or your organizations in AWS Organizations.

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the **`network-prod`** AWS account
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`Resource Access Manager`**
6. Select **`Create a resource share`**
7. Fill out the resource share form details.  Some suggested fields are below:

|Field|Recommendation|
|-----|---------------|
|**`Name`**|`infra-main`|
|**`Select resource type`**|Transit Gateways (and select your transit gateway)|
|**`Allow external accounts`**|Uncheck this option so that you disallow access from AWS accounts outside your AWS organization|

8. Select  **`Create resource share`**