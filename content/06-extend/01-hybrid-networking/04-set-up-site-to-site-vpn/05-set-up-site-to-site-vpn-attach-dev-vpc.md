---
title: 'Attach Development VPC to Transit Gateway'
menuTitle: '5. Attach Development VPC'
disableToc: true
weight: 50
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this section, you'll attach the common development VPC to the transit gateway and update the VPC's route table to route on-premises network traffic to the transit gateway.

{{% notice info %}}
**Attaching team development VPC does not require resource sharing:** The team development VPC is created and managed in the same **`network-prod`** AWS account in which your transit gateway was created. Consequently, you do not need to share the transit gateway resource in order to attach the common team development VPC to your transit gateway. However, since your other VPCs will reside in separate AWS accounts, you will need to enable resource sharing and share the transit gateway in order to attach those VPCs. You will enable resource sharing of your transit gateway in another section.
{{% /notice %}}

{{< toc >}}

## 1. Attach team development VPC to your transit gateway

Create a VPC attachment to your transit gateway for your common team development VPC.  

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the **`network-prod`** AWS account
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`VPC`**
6. Select **`Transit Gateway Attachments`** in the left navigation panel
7. Select **`Create Transit Gateway Attachment`**
8. Provide settings for the fields:

|Field|Recommendation|
|-----|---------------|
|**`Transit Gateway ID`**|Select your transit gateway|
|**`Attachment type`**|`VPC`|
|**`Attachment tag name`**|For example, use the same name as the VPC resource: `infra-dev-vpc`|
|**`DNS support`**|checked|
|**`IP v6 support`**|only check if you are using IP v6 - otherwise, leave unchecked|
|**`VPC ID`**|Select the common team development VPC|
|**`Subnet IDs`**|Select all of the private subnets in the VPC|

9. Select **`Create attachment`**

## 2. Update team development VPC route table

In this step, you'll update the route table for each of the private subnets in the **`dev-infra-shared`** VPC to add an entry to route traffic destined to your on-premises network to the transit gateway.

1. Select **`Route Tables`**
2. For each of the private subnets, modify the route table:
  1. Select route table entry in the list
  2. Select the **`Routes`** tab
  3. Select **`Edit routes`**
  4. Add a new route:

|Field|Recommendation|
|-----|---------------|
|**`Destination`**|Specify the CIDR range of your on-premises network|
|**`Target`**|Select your transit gateway. For example, **`infra-main`**|

{{% notice info %}}
**Routing internet bound traffic to on-premises:** If you choose to route all internet bound traffic back through your on-premises network, you can add another route for `0.0.0.0/0` in your route tables. You can use this approach as a temporary measure to direct all internet bound traffic through your existing on-premises network security services. Once you establish those services in your AWS environment, you can update the routing configuration as appropriate.
{{% /notice %}}