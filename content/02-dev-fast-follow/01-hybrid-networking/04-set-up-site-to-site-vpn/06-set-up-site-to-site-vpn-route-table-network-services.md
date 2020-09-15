---
title: 'Configure Transit Gateway Route Table for Network Services'
menuTitle: '6. Configure Network Services Route Table'
disableToc: true
weight: 60
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this section, you'll create the first of two transit gateway route tables in the **`network-prod`** AWS account so that you have control over which of your VPCs can access the site-to-site VPN connection and the infrastructure shared services VPC that you'll set up in a later section.

{{< toc >}}

## 1. Create transit gateway route table

Create a transit gateway route table for the site-to-site VPN connection and the infrastructure shared services VPC that you'll be creating in another section. We'll refer to this route table as our network services route table.

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
|**`Name`**|`infra-network-services`|
|**`Transit Gateway ID`**|Select your transit gateway from the list|

9. Select **`Create Transit Gateway Route Table`**

## 2. Associate route table with VPN attachment

1. Select the **`infra-network-services`** route table
2. Once the state of the route table transitions to **`available`**, select the **`Associations`** tab. You might have to refresh the page to see the state change.
3. Select **`Create association`**
4. Select the attachment to associate:

|Field|Recommendation|
|-----|---------------|
|**`Choose attachment to associate`**|Choose the transit gateway attachment id for the VPN attachment. For example, **`infra-dc1-01`**|

5. Select **`Create association`**

## 3. Create propagation

Now that you've associated the site-to-site VPN attachment with the route table, you need to enable transit gateway to route traffic from the site-to-site VPN connection to the team development VPC.  You do this by adding a propagation to your route table.  The propagation will propagate the routing information associated with the team development VPC attachment to this route table.

1. Once the state of the association transitions to **`associated`**, select the **`Propagations`** tab. You might have to refresh the page to see the state change.
2. Select **`Create propagation`**
3. Select the attachment to propagate

|Field|Recommendation|
|-----|---------------|
|**`Choose attachment to propogate`**|Select the transit gateway attachment id for the common team development VPC attachment|

4. Select **`Create propagation`**

## 4. Confirm propagation of on-premises routing information

1. Select the **`Routes`** tab.
2. Your should see the CIDR range associated with your common team development VPC in the list of routes.

{{% notice info %}}
**Adding test and production workload VPCs:** As you create your test and production workload VPCs, you'll attach those to the transit gateway and add a propagation for each attachment to this route table. These propagations will enable traffic from both the site-to-site VPN connection and the infrastructure shared services VPCs to be routed to the workload VPCs.
{{% /notice %}}