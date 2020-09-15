---
title: 'Attach Other Workload VPCs to Transit Gateway'
menuTitle: '9. Attach Other Workload VPCs'
disableToc: true
weight: 90
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this section, you attach a workload VPC to your transit gateway and associate it with the workload oriented transit gateway route table.

Repeat the following steps for each workload VPC that you need to associate with your transit gateway.

{{< toc >}}

## 1. Attach workload VPC to your transit gateway

First, access the AWS account in which the workload VPC of interest resides and create an attachment:

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the AWS account that contains a VPC that you need to attach to your transit gateway.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`VPC`**
6. Select **`Transit Gateway Attachments`** in the left navigation panel
7. Select **`Create Transit Gateway Attachment`**
8. Fill out the resource share form details.  Some suggested fields are below:

|Field|Recommendation|
|-----|---------------|
|**`Transit Gateway ID`**|Select your transit gateway|
|**`Attachment type`**|VPC|
|**`Attachment tag name`**|Use the name of the VPC|
|**`DNS support`**|checked|
|**`IP v6 support`**|only check if you are using IP v6 - otherwise, leave unchecked|
|**`VPC ID`**|Choose the VPC that you want to attach|
|**`Subnet IDs`**|Select all of the subnets with which you want to associate with the transit gateway|

9. Select **`Create attachement`**

## 2. Accept transit gateway attachment request

Next, access the **`network-prod`** AWS account to accept the attachment request:

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the **`network-prod`** AWS account
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`VPC`**
6. Select **`Transit Gateway Attachments`** in the left navigation panel

Within the table, you will see the list of your new **`pending acceptance`** transit gateway attachments.

1. Select the checkbox next to each row where the status is **`pending acceptance`** 
2. Select **`Actions`** and select **`Accept`**
3. A prompt will pop up. Select **`Accept`** to confirm acceptance of the attachment

## 3. Associate route table with VPC attachment

1. Select the **`infra-workloads-vpcs`** route table
2. Once the state of the route table transitions to **`available`**, select the **`Associations`** tab. You might have to refresh the page to see the state change.
3. Select **`Create association`**
4. Select the attachment to associate:

|Field|Recommendation|
|-----|---------------|
|**`Choose attachment to associate`**|Choose the transit gateway attachment id for the VPC attachment of interest|

5. Select **`Create association`**

## 4. Create propagation in network services route table

In order to allow traffic from your site-to-site VPN connection to be routed to the workload VPC, you will need to add a propagation for the VPC attachment to the network services route table.

1. Select the **`infra-network-services`** route table
2. Select the **`Propagations`** tab
3. Select **`Create propagation`**
4. Select the attachment to propagate

|Field|Recommendation|
|-----|---------------|
|**`Choose attachment to propogate`**|Select the transit gateway attachment id for the workload VPC attachment of interest|

5. Select **`Create propagation`**

## 5. Confirm propagation of routing information

1. Select the **`Routes`** tab.
2. You should see the CIDR range of the workload VPC of interest listed in the set of routes.

## 6. Update VPC route table

In this step, you'll update the route table for each of the subnets in the workload VPC to add an entry to route traffic destined to your on-premises network to the transit gateway.

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