---
title: 'Configure Transit Gateway Route Table for Workload VPCs'
menuTitle: '7. Configure Workload VPC Route Table'
disableToc: true
weight: 70
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this section, you'll create a second transit gateway route table in the **`network-prod`** AWS account so that you have control over which of your VPCs can access the site-to-site VPN connection and the infrastructure shared services VPC that you'll set up in a later section.  You'll associate your workload hosting VPCs with this second route table.

{{< toc >}}

## 1. Create transit gateway route table

Create a transit gateway route table for your workload hosting VPCs:

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the **`network-prod`** AWS account
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`VPC`**
6. Select **`Transit Gateway Route Tables`**
7. Select **`Create Transit Gateway Route Table`**
8. Provide the Transit Gateway Route Table details:

|Field|Recommendation|
|-----|---------------|
|**`Name`**|`infra-workloads-vpcs`|
|**`Transit Gateway ID`**|Select your transit gateway from the list|

9. Select **`Create Transit Gateway Route Table`**

## 2. Associate route table with common team development VPC attachment

1. Select the **`infra-workloads-vpcs`** route table
2. Once the state of the route table transitions to **`available`**, select the **`Associations`** tab. You might have to refresh the page to see the state change.
3. Select **`Create association`**
4. Select the attachment to associate:

|Field|Recommendation|
|-----|---------------|
|**`Choose attachment to associate`**|Choose the transit gateway attachment id for the common team development VPC attachment. For example, **`infra-dev-shared`**|

5. Select **`Create association`**

## 3. Create propagation

Now that you've associated the team development VPC with the route table, you need to enable transit gateway to route traffic from the team development VPC to your on-premises network via your site-to-site VPN connection.  You do this by adding a propagation to your route table.  The propagation will propagate the routing information associated with the site-to-site VPN connection attachment to this route table.

1. Once the state of the association transitions to **`associated`**, select the **`Propagations`** tab. You might have to refresh the page to see the state change.
2. Select **`Create propagation`**
3. Select the attachment to propagate

|Field|Recommendation|
|-----|---------------|
|**`Choose attachment to propogate`**|Select the transit gateway attachment id for the site-to-site VPN attachment|

4. Select **`Create propagation`**

## 4. Confirm propagation of routing information

1. Select the **`Routes`** tab.
2. If you configured your site-to-site VPN connection to use BGP, then you should see the routing information for your on-premises network listed in the **`Routes`** section.  When using BGP, this routing information will be dynamically updated as you modify your on-premises routing information via your customer gateway.

{{% notice info %}}
**Adding shared infrastructure services VPC:** Later, when you create your shared infrastructure services VPC, you'll attach that VPC to the transit gateway and add a propagation for the attachment to this route table. This propagation will enable traffic from the workload VPCs to be routed the shared infrastructure services VPC.
{{% /notice %}}