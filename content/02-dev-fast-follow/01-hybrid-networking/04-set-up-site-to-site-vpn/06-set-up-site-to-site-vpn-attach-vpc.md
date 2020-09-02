---
title: 'Attach Development VPC to Transit Gateway'
menuTitle: '6. Attach Development VPC'
disableToc: true
weight: 60
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this section, you'll attach the common development VPC to the transit gateway and create a dedicated transit gateway route table for your common development VPC and the test and production workload oriented VPC s that you'll create in subsequent sections.

In order to attach a VPC to the transit gateway, you'll need to enable sharing via AWS Resource Access Manager. 

After attaching the common development VPC, you'll create your second transit gateway route table.  This route table will be dedicated to your common development VPC and the test and production workload-oriented VPCs that you'll set up in a subsequent section.

{{< toc >}}

## 1. Enable resource sharing in your master account

You will need to enable sharing resources within your AWS Organizations from your master account.  This will allow you to access Transit Gateway from each of your accounts created and maintained within Control Tower.

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the **`master`** AWS account
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`Resource Access Manager`**
6. Click the **`Settings`** in the left navigation panel
7. Check the **`Enable sharing within your AWS Organizations`** checkbox, then click the **`Save settings`** button

{{% notice info %}}
**Find your Organization ID:** Navigate to AWS Organizations and click on any of the accounts to open the information panel on the right.  Within the **`ARN`**, after the word account, you will see your Organization ID (starts with **`o-`**).  Note this down for the next set of steps.
{{% /notice %}}

## 2. Sharing your Transit Gateway to your other accounts

You will use AWS Resource Access Manager (RAM) to share your Transit Gateway for VPC attachments across your accounts and/or your organizations in AWS Organizations.

1. Navigate to **`Resource Access Manager`**
2. Click the **`Create a resource share`** button
3. Fill out the resource share form details.  Some suggested fields are below:

|Field|Recommendation|
|-----|---------------|
|**`Name`**|infra-network-tgw-share-01|
|**`Select resource type`**|Transit Gateways (and select your Transit Gateway)|
|**`Allow external accounts`**|(checked)|
|**`Add AWS account number, OU or organization`**|Enter the Organization ID from your master account (captured in the above steps)|

## 3. Create VPC attachments to your Transit Gateway

You will create VPC attachments to your Transit Gateway within each individual account.  THis is available now that you have shared the Transit Gateway via Resource Access Manager to your root organization.

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the **`dev`** AWS account
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`VPC`**
6. Click the **`Transit Gateway Attachments`** in the left navigation panel
7. Click the **`Create Transit Gateway Attachment`** button
8. Fill out the resource share form details.  Some suggested fields are below:

|Field|Recommendation|
|-----|---------------|
|**`Transit Gateway ID`**|Select your transit gateway|
|**`Attachment type`**|VPC|
|**`Attachment tag name`**|tgw-dev|
|**`DNS support`**|checked|
|**`IP v6 support`**|only check if you are using IP v6 - otherwise, leave unchecked|
|**`VPC ID`**|Choose the VPC within your shared dev account that you want to attach|
|**`Subnet IDs`**|check any private subnets in the VPC that you want as part of the attachment|

{{% notice info %}}
**Repeat for other VPCs:** Repeat this step for any other accounts and VPCs that you want attached to the Transit Gateway.
{{% /notice %}}

## 4. Accept the Transit Gateway attachment requests

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the **`infrastructure`** AWS account
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`VPC`**
6. Click the **`Transit Gateway Attachments`** in the left navigation panel

Within the table, you will see the list of your new **`pending acceptance`** transit gateway attachments.

1. Click the checkbox next to a row where the status is **`pending acceptance`** 
2. Click on the **`Actions`** button and select **`Accept`**
3. A prompt will popup - click **`Accept`** to confirm acceptance of the attachment

## 5. Create Transit Gateway Route tables for VPCs

1. Select **`Transit Gateway Route Tables`**
2. Click **`Create Transit Gateway Route Table`**
3. Provide the Transit Gateway Route Table details:

|Field|Recommendation|
|-----|---------------|
|**`Name`**|tgw-ssdev-rt|
|**`Transit Gateway ID`**|Select your transit gateway from the list|

Click **`Create Transit Gateway Route Table`**

Once the Transit Gateway Route Table is **`available`**, click on the **`Associations`** table at the bottom of the screen.
1. Click **`Create association`**
2. Choose the attachment to associate

|Field|Recommendation|
|-----|---------------|
|**`Choose attachment to associate`**|Choose the transit Gateway attachment id for the VPC attachment|

Click **`Create association`**

Once the Association is **`associated`**, click on the **`Propagations`** tab
1. Click **`Create propagation`**
2. Choose the attachment to propagate (your VPC attachments setup in Step 11 - Repeat for each association to be added)

Repeat for each association to be added

|Field|Recommendation|
|-----|---------------|
|**`Choose attachment to propogate`**|Choose the transit Gateway attachment id for the VPC attachment|

Click **`Create propagation`**

Click on the **`Routes`** tab and you should see that there is a route entry for your VPC CIDR.

## 6. Update Development VPC Route Table

In this step, you'll update the route table for each of the private subnets in the **`dev-infra-shared`** VPC to add an entry to route traffic destined to your on-premises network to the transit gateway.

1. Select **`Route Tables`**
2. For each of the private subnet, modify the route table:
  1. Select route table entry in the list
  2. Select the **`Routes`** tab
  3. Select **`Edit routes`**
  4. Add a new route:

|Field|Recommendation|
|-----|---------------|
|**`Destination`**|Specify the CIDR range of your on-premises network|
|**`Target`**|Select your transit gateway. For example, **`infra-main`**|